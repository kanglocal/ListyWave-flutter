import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/intro/presentation/intro_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

void _mockOnboarding(ApiMock api) => api.adapter
  ..onGet('/users/exists', (s) => s.reply(200, false))
  ..onGet(
    '/users/exists',
    (s) => s.reply(200, true),
    queryParameters: {'nickname': '중복'},
  )
  ..onPatch('/users/9', (s) => s.reply(204, null), data: Matchers.any)
  ..onPost('/lists', (s) => s.reply(201, {'listId': 7}), data: Matchers.any);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _enter(WidgetTester tester, String key, String text) async {
  await tester.enterText(find.byKey(Key(key)), text);
  await tester.pump();
}

final _next = find.byKey(const Key('onboarding.next'));

bool _enabled(WidgetTester tester) =>
    tester.widget<FilledButton>(_next).onPressed != null;

void main() {
  testWidgets('닉네임 11자는 최대 10자 오류로 막는다', (tester) async {
    final (container, _) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockOnboarding,
    );
    container.read(routerProvider).go(AppRoutes.startListy);
    await settle(tester);

    await _enter(tester, 'onboarding.nickname', 'abcdefghijk');

    expect(find.text('닉네임은 최대 10자까지 입력할 수 있어요.'), findsOneWidget);
    expect(_enabled(tester), isFalse);
  });

  testWidgets('이미 쓰는 닉네임이면 PATCH 하지 않고 중복 오류를 보인다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockOnboarding,
    );
    container.read(routerProvider).go(AppRoutes.startListy);
    await settle(tester);

    await _enter(tester, 'onboarding.nickname', '중복');
    await _tap(tester, _next);
    await settle(tester);

    expect(find.text('이미 사용중인 닉네임이에요.'), findsOneWidget);
    expect(writesOf(api), isEmpty);
  });

  testWidgets(
    '닉네임 → 카테고리 → 제목 → 아이템 3개를 마치면 PATCH /users/{id} 와 POST /lists 후 인트로로 간다',
    (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockOnboarding,
      );
      final router = container.read(routerProvider);
      router.go(AppRoutes.startListy);
      await settle(tester);

      await _enter(tester, 'onboarding.nickname', '리스티짱');
      await _tap(tester, _next);
      await settle(tester);
      expect(api.sent('PATCH', '/users/9').single.data, {'nickname': '리스티짱'});

      expect(_enabled(tester), isFalse);
      await _tap(tester, find.byKey(const Key('onboarding.category.travel')));
      await _tap(tester, _next);
      await _enter(tester, 'onboarding.title', '제주 맛집');
      await _tap(tester, _next);
      for (var i = 0; i < 3; i++) {
        await _enter(tester, 'onboarding.item.$i', '식당${i + 1}');
      }
      await _tap(tester, _next);
      await settle(tester);

      expect(writesOf(api), ['PATCH /users/9', 'POST /lists']);
      expect(api.sent('POST', '/lists').single.data, {
        'category': 'travel',
        'labels': <String>[],
        'collaboratorIds': <int>[],
        'title': '제주 맛집',
        'description': '',
        'isPublic': false,
        'backgroundPalette': 'NEON',
        'backgroundColor': 'NEON_BLUE',
        'items': [
          for (var rank = 1; rank <= 3; rank++)
            {
              'rank': rank,
              'title': '식당$rank',
              'comment': '',
              'link': '',
              'imageUrl': '',
            },
        ],
      });
      expect(router.state.uri.toString(), AppRoutes.intro);
      expect(find.byType(IntroScreen), findsOneWidget);
    },
  );

  testWidgets('Skip 을 확인하면 홈으로 간다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockOnboarding,
    );
    final router = container.read(routerProvider);
    router.go(AppRoutes.startListy);
    await settle(tester);
    await _enter(tester, 'onboarding.nickname', '리스티짱');
    await _tap(tester, _next);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('onboarding.skip')));
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(router.state.uri.toString(), '/');
    expect(writesOf(api), ['PATCH /users/9']);
  });
}
