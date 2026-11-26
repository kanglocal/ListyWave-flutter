import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/app_shell.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/follow/presentation/followers_screen.dart';
import 'package:listywave_app/features/follow/presentation/followings_screen.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

/// userId 9 로 로그인한 앱. 세션 확인(`GET /users/9`)부터 fixture 로 응답한다.
Future<ProviderContainer> _pumpLoggedIn(
  WidgetTester tester,
  void Function(ApiMock api) onMock,
) => pumpApp(
  tester,
  secure: {'accessToken': 'at', 'refreshToken': 'rt'},
  prefs: {'userId': 9},
  beforePump: (c) {
    final api = ApiMock(c);
    mockReadApis(api);
    onMock(api);
  },
);

void main() {
  testWidgets(
    '내 마이리스트는 /users/{id} 와 /users/{id}/lists?type=my&size=10 을 부른다',
    (tester) async {
      late ApiMock api;
      final container = await _pumpLoggedIn(tester, (mock) => api = mock);

      container.read(routerProvider).go(AppRoutes.myList('9'));
      await settle(tester);

      expect(find.byType(UserProfileScreen), findsOneWidget);
      expect(find.byType(AppBottomNav), findsOneWidget);
      expect(api.sent('GET', '/users/9'), isNotEmpty);
      expect(queriesOf(api, '/users/9/lists'), [
        {'type': 'my', 'category': 'entire', 'size': '10'},
      ]);
      // 로그인 사용자의 요청이다.
      expect(
        authorizationOf(api.sent('GET', '/users/9/lists').single),
        'Bearer at',
      );

      expect(find.text('리스티'), findsOneWidget);
      expect(find.text('1만 팔로워'), findsOneWidget);
      expect(find.text('리스티님의 리스트'), findsOneWidget);
      // 주인이면 비공개 리스트도 보인다.
      expect(find.text('나의 리스트 2'), findsOneWidget);
      expect(find.text('비공개'), findsOneWidget);

      // 카테고리 필터.
      await tester.tap(find.byKey(const Key('category.4')));
      await settle(tester);
      expect(queriesOf(api, '/users/9/lists').last, {
        'type': 'my',
        'category': 'travel',
        'size': '10',
      });
    },
  );

  testWidgets('콜라보 리스트 탭은 type=collabo 로 부른다', (tester) async {
    late ApiMock api;
    final container = await _pumpLoggedIn(tester, (mock) => api = mock);
    container.read(routerProvider).go(AppRoutes.myList('9'));
    await settle(tester);

    await tester.tap(find.text('콜라보 리스트'));
    await settle(tester);

    final profile = tester.widget<UserProfileScreen>(
      find.byType(UserProfileScreen),
    );
    expect(profile.tab, UserProfileTab.collabo);
    expect(queriesOf(api, '/users/9/lists').last, {
      'type': 'collabo',
      'category': 'entire',
      'size': '10',
    });
  });

  testWidgets('다른 사람의 리스트는 공개 리스트만 보이고, 팔로워/팔로잉 목록으로 갈 수 있다', (tester) async {
    late ApiMock api;
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    container.read(routerProvider).push(AppRoutes.myList('3'));
    await settle(tester);

    expect(queriesOf(api, '/users/3/lists'), [
      {'type': 'my', 'category': 'entire', 'size': '10'},
    ]);
    expect(find.text('나의 리스트 1'), findsOneWidget);
    expect(find.text('나의 리스트 2'), findsNothing);
    // 카테고리 이름을 보인다.
    expect(find.text('음악'), findsWidgets);
  });

  testWidgets('팔로워/팔로잉 화면은 /users/{id}/followers, /followings 를 부른다', (
    tester,
  ) async {
    late ApiMock api;
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    final router = container.read(routerProvider);

    router.push(AppRoutes.followers('9'));
    await settle(tester);
    expect(find.byType(FollowersScreen), findsOneWidget);
    expect(api.sent('GET', '/users/9/followers'), hasLength(1));
    expect(find.text('서핑하는개발자'), findsOneWidget);
    expect(find.text('영화광'), findsOneWidget);

    router.push(AppRoutes.followings('9'));
    await settle(tester);
    expect(find.byType(FollowingsScreen), findsOneWidget);
    expect(api.sent('GET', '/users/9/followings'), hasLength(1));
    expect(find.text('빵지순례'), findsOneWidget);
  });

  testWidgets('팔로워가 없으면 빈 안내를 보인다', (tester) async {
    late ApiMock api;
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
        api.adapter.onGet(
          '/users/9/followers',
          (s) => s.reply(200, {
            'followers': <Object>[],
            'totalCount': 0,
            'cursorId': null,
            'hasNext': false,
          }),
        );
      },
    );
    container.read(routerProvider).push(AppRoutes.followers('9'));
    await settle(tester);

    expect(find.text('아직은 팔로워가 없어요'), findsOneWidget);
  });
}
