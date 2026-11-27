import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/collection/presentation/collection_folders_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_list_screen.dart';

import '../../helpers/login_fixtures.dart';
import '../../helpers/pump_app.dart';

void main() {
  test('web REQUIRED_TOKEN 경로만 로그인이 필요하다', () {
    for (final path in [
      '/account',
      '/account/profile',
      '/account/withdraw',
      '/start-listy',
      '/list/create',
      '/collection',
      '/collection/5',
      '/notification',
    ]) {
      expect(isAuthRequired(path), isTrue, reason: path);
    }
    for (final path in [
      '/',
      '/intro',
      '/list/7',
      '/user/3/mylist',
      '/search',
      '/notice',
      '/accounts',
      '/login',
    ]) {
      expect(isAuthRequired(path), isFalse, reason: path);
    }
  });

  testWidgets(
    '비로그인으로 /collection 에 가면 로그인 sheet 가 뜨고, 로그인 뒤 /collection 에 도착한다',
    (tester) async {
      late ApiMock api;
      final secure = <String, String>{};
      final container = await pumpApp(
        tester,
        secure: secure,
        beforePump: (c) {
          api = ApiMock(c);
          api.adapter.onPost(
            '/login/local',
            (s) => s.reply(200, loginJson(id: 3)),
            data: {'account': 'tester', 'password': 'pw'},
          );
        },
      );
      final router = container.read(routerProvider);
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.loggedOut,
      );

      router.go(AppRoutes.collection);
      await tester.pumpAndSettle();

      // 이동은 막히고, 지금 화면(홈) 위에 sheet 가 뜬다.
      expect(find.byType(LoginSheet), findsOneWidget);
      expect(find.byType(CollectionFoldersScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(locationOf(router), '/');

      await tester.tap(find.byKey(const Key('login.local')));
      await tester.pumpAndSettle();

      expect(api.sent('POST', '/login/local'), hasLength(1));
      expect(locationOf(router), '/collection');
      expect(find.byType(CollectionFoldersScreen), findsOneWidget);
      expect(find.byType(LoginSheet), findsNothing);
      expect(
        container.read(authControllerProvider),
        const AuthState.loggedIn(3),
      );
      expect(secure, {'accessToken': 'at-3', 'refreshToken': 'rt-3'});
    },
  );

  testWidgets('guard 가 띄운 sheet 를 닫으면 원래 화면에 머문다', (tester) async {
    final container = await pumpApp(tester);
    final router = container.read(routerProvider)..go(AppRoutes.notice);
    await tester.pumpAndSettle();

    router.go('/collection/5');
    await tester.pumpAndSettle();
    expect(find.byType(LoginSheet), findsOneWidget);
    expect(locationOf(router), '/notice');

    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();

    expect(locationOf(router), '/notice');
    expect(find.byType(NoticeListScreen), findsOneWidget);
    expect(find.byType(LoginSheet), findsNothing);
  });

  testWidgets('로그인 상태면 보호 경로를 그대로 보여 준다', (tester) async {
    final container = await pumpLoggedInApp(tester);
    final router = container.read(routerProvider);
    expect(container.read(authControllerProvider), const AuthState.loggedIn(9));

    router.go(AppRoutes.collection);
    await tester.pumpAndSettle();

    expect(find.byType(CollectionFoldersScreen), findsOneWidget);
    expect(find.byType(LoginSheet), findsNothing);
  });

  testWidgets('보호 경로에 있다가 세션이 만료되면 refresh 로 로그인 sheet 가 뜨고, 닫으면 홈으로 간다', (
    tester,
  ) async {
    final container = await pumpLoggedInApp(tester);
    final router = container.read(routerProvider)..go(AppRoutes.collection);
    await tester.pumpAndSettle();
    expect(find.byType(CollectionFoldersScreen), findsOneWidget);

    await container
        .read(authControllerProvider.notifier)
        .logout(LogoutReason.expired);
    await tester.pumpAndSettle();

    expect(locationOf(router), '/login?from=%2Fcollection');
    expect(find.byType(LoginSheet), findsOneWidget);
    expect(find.byType(CollectionFoldersScreen), findsNothing);

    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();
    expect(locationOf(router), '/');
  });

  testWidgets('세션이 만료되면 "다시 로그인해주세요" 안내가 뜬다', (tester) async {
    final container = await pumpLoggedInApp(tester);

    await container
        .read(authControllerProvider.notifier)
        .logout(LogoutReason.expired);
    await tester.pumpAndSettle();

    expect(find.text('로그아웃 된 사용자에요. 다시 로그인 해주세요.'), findsOneWidget);
  });

  testWidgets('공개 경로는 비로그인이어도 막지 않는다', (tester) async {
    final container = await pumpApp(tester);
    container.read(routerProvider).go(AppRoutes.notice);
    await tester.pumpAndSettle();

    expect(find.byType(NoticeListScreen), findsOneWidget);
    expect(find.byType(LoginSheet), findsNothing);
  });
}
