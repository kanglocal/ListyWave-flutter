import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/list_editor/presentation/list_create_screen.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';
import '../helpers/write_api_mocks.dart';

void _mockTopics(ApiMock api) => api.adapter
  ..onGet('/topics', (s) => s.reply(200, fixture('topics')))
  ..onPost('/topics', (s) => s.reply(204, null), data: Matchers.any);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('GET /topics?size=10 으로 요청 주제를 보이고, 익명이면 닉네임을 숨긴다', (
    tester,
  ) async {
    final (container, api) = await pumpWithApi(tester, onMock: _mockTopics);
    container.read(routerProvider).push(AppRoutes.topics);
    await settle(tester);

    expect(queriesOf(api, '/topics').first, {'size': '10'});
    expect(find.text('비 오는 날 듣기 좋은 노래'), findsOneWidget);
    expect(find.text('영화광'), findsOneWidget);
    expect(find.text('혼밥하기 좋은 식당'), findsOneWidget);
    expect(find.text('맛집탐방러'), findsNothing);
    expect(find.text('익명'), findsOneWidget);
  });

  testWidgets('주제를 누르면 그 제목과 카테고리(한글)로 리스트 만들기를 연다', (tester) async {
    final (container, _) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockTopics,
    );
    final router = container.read(routerProvider);
    router.push(AppRoutes.topics);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('topics.topic.8')));
    await settle(tester);

    final uri = router.state.uri;
    expect(uri.path, AppRoutes.listCreate);
    expect(uri.queryParameters, {'title': '비 오는 날 듣기 좋은 노래', 'category': '음악'});
    final screen = tester.widget<ListCreateScreen>(
      find.byType(ListCreateScreen),
    );
    expect((screen.title, screen.category), ('비 오는 날 듣기 좋은 노래', '음악'));
  });

  testWidgets(
    '주제 요청: POST /topics {categoryKorName, title, description, isAnonymous} 후 목록을 다시 읽는다',
    (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockTopics,
      );
      container.read(routerProvider).push(AppRoutes.topics);
      await settle(tester);

      await _tap(tester, find.byKey(const Key('topics.request')));
      final send = find.byKey(const Key('topics.send'));
      expect(tester.widget<FilledButton>(send).onPressed, isNull);

      await _tap(tester, find.byKey(const Key('topics.category')));
      await _tap(tester, find.text('여행').last);
      await _tap(tester, find.byKey(const Key('topics.anonymous')));
      await tester.enterText(find.byKey(const Key('topics.title')), '제주 동쪽 숙소');
      await tester.enterText(
        find.byKey(const Key('topics.description')),
        '가족 여행용',
      );
      await tester.pump();
      await _tap(tester, send);
      await _tap(tester, find.byKey(const Key('topics.requestDoneClose')));
      await settle(tester);

      expect(api.sent('POST', '/topics').single.data, {
        'categoryKorName': '여행',
        'title': '제주 동쪽 숙소',
        'description': '가족 여행용',
        'isAnonymous': true,
      });
      expect(find.byKey(const Key('topics.send')), findsNothing);
      expect(api.sent('GET', '/topics'), hasLength(2));
    },
  );

  testWidgets('주제 제목이 30자를 넘으면 보낼 수 없다', (tester) async {
    final (container, _) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockTopics,
    );
    container.read(routerProvider).push(AppRoutes.topics);
    await settle(tester);
    await _tap(tester, find.byKey(const Key('topics.request')));
    await _tap(tester, find.byKey(const Key('topics.category')));
    await _tap(tester, find.text('음악').last);
    await tester.enterText(find.byKey(const Key('topics.title')), 'a' * 31);
    await tester.pump();

    expect(find.text('리스트 주제를 30자 이내로 작성해주세요.'), findsOneWidget);
    final send = tester.widget<FilledButton>(
      find.byKey(const Key('topics.send')),
    );
    expect(send.onPressed, isNull);
  });

  testWidgets('비로그인으로 주제 요청을 누르면 로그인 sheet 를 띄운다', (tester) async {
    final (container, api) = await pumpWithApi(tester, onMock: _mockTopics);
    container.read(routerProvider).push(AppRoutes.topics);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('topics.request')));

    expect(find.byType(LoginSheet), findsOneWidget);
    expect(find.byKey(const Key('topics.send')), findsNothing);
    expect(writesOf(api), isEmpty);
  });
}
