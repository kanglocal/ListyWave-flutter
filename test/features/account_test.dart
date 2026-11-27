import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/core/l10n/locale_controller.dart';
import 'package:listywave_app/features/account/presentation/withdrawn_account_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';
import '../helpers/write_api_mocks.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Locale? _appLocale(WidgetTester tester) =>
    tester.widget<MaterialApp>(find.byType(MaterialApp)).locale;

void main() {
  testWidgets('언어를 en 으로 바꾸면 바로 반영되고, 재시작(새 container)해도 en 이다', (
    tester,
  ) async {
    final (container, _) = await pumpWithApi(tester, userId: 9);
    container.read(routerProvider).push(AppRoutes.account);
    await settle(tester);
    expect(_appLocale(tester), const Locale('ko'));
    expect(find.text('설정'), findsOneWidget);

    await _tap(tester, find.byKey(const Key('account.language.en')));
    await settle(tester);

    expect(_appLocale(tester), const Locale('en'));
    expect(find.text('Settings'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(LocaleController.storageKey);
    expect(stored, 'en');

    // 앱을 내리고 다시 띄운다: 새 container 가 shared_preferences 에서 언어를 읽는다.
    await tester.pumpWidget(const SizedBox());
    await pumpApp(
      tester,
      prefs: {LocaleController.storageKey: stored!},
      beforePump: (c) => mockReadApis(ApiMock(c)),
    );
    await settle(tester);

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(_appLocale(tester), const Locale('en'));
  });

  testWidgets('로그아웃: 확인하면 PATCH /auth/kakao 후 로그아웃 상태로 홈에 간다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) =>
          api.adapter.onPatch('/auth/kakao', (s) => s.reply(204, null)),
    );
    final router = container.read(routerProvider);
    router.push(AppRoutes.account);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('account.logout')));
    expect(find.text('로그아웃 하시나요?'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(writesOf(api), ['PATCH /auth/kakao']);
    expect(
      container.read(authControllerProvider),
      const AuthState.loggedOut(reason: LogoutReason.user),
    );
    // 다시 로그인하라는 sheet 없이 홈으로 간다.
    expect(router.state.uri.toString(), '/');
    expect(find.byType(LoginSheet), findsNothing);
    expect(find.text('로그아웃 되었어요.'), findsOneWidget);
  });

  testWidgets('보호 경로에서 직접 로그아웃하면 로그인 sheet 대신 홈으로 보낸다', (tester) async {
    final (container, _) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) => api.adapter
        ..onPatch('/auth/kakao', (s) => s.reply(204, null))
        ..onGet('/folders', (s) => s.reply(200, {'folders': <Object>[]})),
    );
    final router = container.read(routerProvider);
    router.go(AppRoutes.collection);
    await settle(tester);

    // fake async 안에서 mock 응답 Timer 가 흐르도록 기다리지 않고 settle 로 진행한다.
    final done = container
        .read(authControllerProvider.notifier)
        .logout(LogoutReason.user);
    await settle(tester);
    await done;

    expect(router.state.uri.toString(), '/');
    expect(find.byType(LoginSheet), findsNothing);
  });

  testWidgets('탈퇴: 동의하고 확인하면 DELETE /withdraw 후 로그아웃 상태로 / 에 간다', (
    tester,
  ) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) =>
          api.adapter.onDelete('/withdraw', (s) => s.reply(204, null)),
    );
    final router = container.read(routerProvider);
    router.push(AppRoutes.account);
    await settle(tester);
    await _tap(tester, find.byKey(const Key('account.withdraw')));
    await settle(tester);
    expect(router.state.uri.toString(), '/account/withdraw');

    final submit = find.byKey(const Key('withdraw.submit'));
    expect(tester.widget<FilledButton>(submit).onPressed, isNull);
    await _tap(tester, find.byKey(const Key('withdraw.agree')));
    await _tap(tester, submit);
    expect(find.text('확인 버튼 클릭 시 즉시 탈퇴 처리됩니다.'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(writesOf(api), ['DELETE /withdraw']);
    expect(
      container.read(authControllerProvider),
      const AuthState.loggedOut(reason: LogoutReason.withdraw),
    );
    expect(router.state.uri.toString(), '/');
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(LoginSheet), findsNothing);
  });

  testWidgets('탈퇴 요청이 실패하면 로그인 상태로 탈퇴 화면에 남는다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) => api.adapter.onDelete(
        '/withdraw',
        (s) => s.reply(500, serverErrorBody()),
      ),
    );
    final router = container.read(routerProvider);
    router.push(AppRoutes.accountWithdraw);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('withdraw.agree')));
    await _tap(tester, find.byKey(const Key('withdraw.submit')));
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(writesOf(api), ['DELETE /withdraw']);
    expect(container.read(authControllerProvider).isLoggedIn, isTrue);
    expect(router.state.uri.toString(), '/account/withdraw');
    expect(find.text('탈퇴에 실패했어요. 다시 시도해주세요.'), findsOneWidget);
  });

  testWidgets('탈퇴 회원 화면에서 홈으로 돌아간다', (tester) async {
    final (container, _) = await pumpWithApi(tester);
    final router = container.read(routerProvider);
    router.go(AppRoutes.withdrawnAccount);
    await settle(tester);

    expect(find.byType(WithdrawnAccountScreen), findsOneWidget);
    expect(find.text('탈퇴한 회원이에요'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('withdrawnAccount.home')));
    await settle(tester);

    expect(router.state.uri.toString(), '/');
  });
}
