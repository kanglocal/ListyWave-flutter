import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/follow/application/follow_providers.dart';

import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

void main() {
  group('프로필 팔로우', () {
    testWidgets('누르면 바로 팔로우 취소 버튼과 팔로워 +1 을 보이고 POST /follow/{id} 를 보낸다', (
      tester,
    ) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) =>
            api.adapter.onPost('/follow/3', (s) => s.reply(204, null)),
      );
      container.read(routerProvider).push(AppRoutes.myList('3'));
      await settle(tester);
      expect(find.text('40 팔로워'), findsOneWidget);

      await tester.tap(find.byKey(const Key('follow.3')));
      await tester.pump();
      expect(find.text('팔로우 취소'), findsOneWidget);
      expect(find.text('41 팔로워'), findsOneWidget);
      await settle(tester);

      expect(api.sent('POST', '/follow/3'), hasLength(1));
      // 성공하면 그 사용자와 내 프로필을 다시 읽는다.
      expect(api.sent('GET', '/users/3').length, greaterThanOrEqualTo(2));
    });

    testWidgets('API 가 500 이면 팔로우 전 상태와 팔로워 수로 되돌린다', (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) => api.adapter.onPost(
          '/follow/3',
          (s) => s.reply(500, serverErrorBody(), delay: serverErrorDelay),
        ),
      );
      container.read(routerProvider).push(AppRoutes.myList('3'));
      await settle(tester);

      await tester.tap(find.byKey(const Key('follow.3')));
      await tester.pump();
      expect(container.read(followControllerProvider), {3: true});
      expect(find.text('41 팔로워'), findsOneWidget);

      await tester.pump(serverErrorDelay * 2);
      await settle(tester);
      expect(container.read(followControllerProvider), isEmpty);
      expect(find.text('팔로우'), findsOneWidget);
      expect(find.text('40 팔로워'), findsOneWidget);
      expect(api.sent('POST', '/follow/3'), hasLength(1));
      expect(find.text('팔로우 변경에 실패했어요. 다시 시도해주세요.'), findsOneWidget);
    });

    testWidgets('비로그인이면 로그인 sheet 를 띄우고 요청하지 않는다', (tester) async {
      final (container, api) = await pumpWithApi(tester);
      container.read(routerProvider).push(AppRoutes.myList('3'));
      await settle(tester);

      await tester.tap(find.byKey(const Key('follow.3')));
      await settle(tester);

      expect(find.byType(LoginSheet), findsOneWidget);
      expect(writesOf(api), isEmpty);
    });

    testWidgets('내 프로필에는 팔로우 버튼이 없다', (tester) async {
      final (container, _) = await pumpWithApi(tester, userId: 9);
      container.read(routerProvider).go(AppRoutes.myList('9'));
      await settle(tester);

      expect(find.byKey(const Key('follow.9')), findsNothing);
    });
  });

  testWidgets('검색 리스터의 팔로잉을 누르면 DELETE /follow/{id} 로 언팔로우한다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) =>
          api.adapter.onDelete('/follow/12', (s) => s.reply(204, null)),
    );
    container.read(routerProvider).push('${AppRoutes.search}?keyword=맛집');
    await settle(tester);

    // backend 가 준 isFollowing 을 그대로 보인다.
    final button = find.byKey(const Key('follow.12'));
    expect(
      find.descendant(of: button, matching: find.text('팔로잉')),
      findsOneWidget,
    );
    await tester.ensureVisible(button);
    await tester.tap(button);
    await settle(tester);

    expect(api.sent('DELETE', '/follow/12'), hasLength(1));
    expect(
      find.descendant(of: button, matching: find.text('팔로우')),
      findsOneWidget,
    );
  });

  testWidgets('추천 리스터의 팔로우는 POST /follow/{id} 를 보낸다', (tester) async {
    final (_, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) =>
          api.adapter.onPost('/follow/8', (s) => s.reply(204, null)),
    );
    await settle(tester);

    final button = find.byKey(const Key('follow.8'));
    final feed = find
        .descendant(
          of: find.byKey(const Key('home.recommendation')),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(button, 200, scrollable: feed);
    // 하단 탭 위로 올라오게 조금 더 내린다.
    await tester.drag(feed, const Offset(0, -200));
    await settle(tester);
    await tester.tap(button);
    await settle(tester);

    expect(api.sent('POST', '/follow/8'), hasLength(1));
  });

  group('팔로워 삭제', () {
    testWidgets('내 팔로워 목록에서 확인 뒤 DELETE /followers/{id} 를 보내고 목록에서 뺀다', (
      tester,
    ) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) =>
            api.adapter.onDelete('/followers/5', (s) => s.reply(204, null)),
      );
      container.read(routerProvider).push(AppRoutes.followers('9'));
      await settle(tester);
      expect(find.text('영화광'), findsOneWidget);

      await tester.tap(find.byKey(const Key('follower.5.delete')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('confirmDialog.confirm')));
      await settle(tester);

      expect(api.sent('DELETE', '/followers/5'), hasLength(1));
      expect(find.text('영화광'), findsNothing);
      expect(find.text('서핑하는개발자'), findsOneWidget);
    });

    testWidgets('API 가 500 이면 목록에 되돌린다', (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) => api.adapter.onDelete(
          '/followers/5',
          (s) => s.reply(500, serverErrorBody(), delay: serverErrorDelay),
        ),
      );
      container.read(routerProvider).push(AppRoutes.followers('9'));
      await settle(tester);

      await tester.tap(find.byKey(const Key('follower.5.delete')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('confirmDialog.confirm')));
      await tester.pump();
      await tester.pump();
      expect(find.text('영화광'), findsNothing);

      await tester.pump(serverErrorDelay * 2);
      await settle(tester);
      expect(find.text('영화광'), findsOneWidget);
      expect(api.sent('DELETE', '/followers/5'), hasLength(1));
    });

    testWidgets('다른 사람의 팔로워 목록에는 삭제 버튼이 없다', (tester) async {
      final (container, _) = await pumpWithApi(tester, userId: 3);
      container.read(routerProvider).push(AppRoutes.followers('9'));
      await settle(tester);

      expect(find.byKey(const Key('follower.5.delete')), findsNothing);
    });
  });

  testWidgets('마이리스트 카드 메뉴로 공개/비공개를 바꾸면 PATCH 후 목록을 다시 읽는다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: (api) => api.adapter.onPatch(
        '/lists/401/visibility',
        (s) => s.reply(204, null),
      ),
    );
    container.read(routerProvider).go(AppRoutes.myList('9'));
    await settle(tester);
    expect(api.sent('GET', '/users/9/lists'), hasLength(1));

    await tester.tap(find.byKey(const Key('listCard.401.menu')));
    await settle(tester);
    await tester.tap(find.text('비공개로 전환하기'));
    await settle(tester);

    expect(api.sent('PATCH', '/lists/401/visibility'), hasLength(1));
    expect(api.sent('GET', '/users/9/lists'), hasLength(2));
  });
}
