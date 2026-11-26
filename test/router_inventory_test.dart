import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/account/presentation/account_screen.dart';
import 'package:listywave_app/features/account/presentation/profile_edit_screen.dart';
import 'package:listywave_app/features/account/presentation/withdraw_screen.dart';
import 'package:listywave_app/features/account/presentation/withdrawn_account_screen.dart';
import 'package:listywave_app/features/collection/presentation/collection_folder_screen.dart';
import 'package:listywave_app/features/collection/presentation/collection_folders_screen.dart';
import 'package:listywave_app/features/follow/presentation/followers_screen.dart';
import 'package:listywave_app/features/follow/presentation/followings_screen.dart';
import 'package:listywave_app/features/history/presentation/list_history_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/intro/presentation/intro_screen.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/list_editor/presentation/list_create_screen.dart';
import 'package:listywave_app/features/list_editor/presentation/list_edit_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_detail_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_list_screen.dart';
import 'package:listywave_app/features/notification/presentation/notification_screen.dart';
import 'package:listywave_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:listywave_app/features/search/presentation/search_screen.dart';
import 'package:listywave_app/features/topics/presentation/topics_screen.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';

import 'helpers/pump_app.dart';

/// PLAN §2 Screen inventory 의 go_router path 전부 (KakaoLoginWebView 는 route 가 아니다).
const planPaths = <String>{
  '/',
  '/intro',
  '/start-listy',
  '/withdrawn-account',
  '/list/create',
  '/list/:listId',
  '/list/:listId/edit',
  '/list/:listId/history',
  '/user/:userId/mylist',
  '/user/:userId/collabolist',
  '/user/:userId/followers',
  '/user/:userId/followings',
  '/search',
  '/topics',
  '/collection',
  '/collection/:folderId',
  '/notification',
  '/notice',
  '/notice/:noticeId',
  '/account',
  '/account/profile',
  '/account/withdraw',
  '/login',
};

/// 실제 location → 보여야 하는 화면. 보호 경로도 화면이 보이도록 로그인 상태로 띄운다
/// (비로그인 guard 는 test/core/auth/auth_guard_test.dart).
const navigationCases = <String, Type>{
  '/': HomeScreen,
  '/intro': IntroScreen,
  '/start-listy': OnboardingScreen,
  '/withdrawn-account': WithdrawnAccountScreen,
  '/list/create?title=t&category=culture': ListCreateScreen,
  '/list/7': ListDetailScreen,
  '/list/7/edit': ListEditScreen,
  '/list/7/history': ListHistoryScreen,
  '/user/3/mylist': UserProfileScreen,
  '/user/3/collabolist': UserProfileScreen,
  '/user/3/followers': FollowersScreen,
  '/user/3/followings': FollowingsScreen,
  '/search?keyword=a&categoryCode=1&sort=new': SearchScreen,
  '/topics': TopicsScreen,
  '/collection': CollectionFoldersScreen,
  '/collection/5': CollectionFolderScreen,
  '/notification': NotificationScreen,
  '/notice': NoticeListScreen,
  '/notice/9': NoticeDetailScreen,
  '/account': AccountScreen,
  '/account/profile': ProfileEditScreen,
  '/account/withdraw': WithdrawScreen,
  '/login': LoginSheet,
};

Set<String> _collectPaths(List<RouteBase> routes, [String parent = '']) {
  final paths = <String>{};
  for (final route in routes) {
    var base = parent;
    if (route is GoRoute) {
      base = route.path.startsWith('/')
          ? route.path
          : '${parent == '/' ? '' : parent}/${route.path}';
      paths.add(base);
    }
    paths.addAll(_collectPaths(route.routes, base));
  }
  return paths;
}

void main() {
  testWidgets('router 는 PLAN §2 의 path 를 정확히 등록한다', (tester) async {
    final container = await pumpApp(tester);
    final router = container.read(routerProvider);

    expect(_collectPaths(router.configuration.routes), equals(planPaths));
  });

  testWidgets('navigationCases 는 planPaths 를 모두 덮는다', (tester) async {
    final container = await pumpApp(tester);
    final router = container.read(routerProvider);

    final matched = navigationCases.keys
        .map(
          (location) =>
              router.configuration.findMatch(Uri.parse(location)).fullPath,
        )
        .toSet();
    expect(matched, equals(planPaths));
  });

  for (final MapEntry(key: location, value: screen)
      in navigationCases.entries) {
    testWidgets('$location → $screen', (tester) async {
      final container = await pumpLoggedInApp(tester);
      container.read(routerProvider).go(location);
      await tester.pumpAndSettle();

      expect(find.byType(screen), findsOneWidget);
    });
  }

  testWidgets('path/query 파라미터를 화면에 넘긴다', (tester) async {
    final container = await pumpLoggedInApp(tester);
    final router = container.read(routerProvider);

    router.go('/list/create?title=t&category=culture');
    await tester.pumpAndSettle();
    final create = tester.widget<ListCreateScreen>(
      find.byType(ListCreateScreen),
    );
    expect((create.title, create.category), ('t', 'culture'));

    router.go('/user/3/collabolist');
    await tester.pumpAndSettle();
    final profile = tester.widget<UserProfileScreen>(
      find.byType(UserProfileScreen),
    );
    expect((profile.userId, profile.tab), ('3', UserProfileTab.collabo));

    router.go('/search?keyword=a&categoryCode=1&sort=new');
    await tester.pumpAndSettle();
    final search = tester.widget<SearchScreen>(find.byType(SearchScreen));
    expect(
      (search.keyword, search.categoryCode, search.sort),
      ('a', '1', 'new'),
    );
  });

  test('AppRoutes helper 는 등록된 path 와 같은 모양을 만든다', () {
    expect(AppRoutes.listDetail('1'), '/list/1');
    expect(AppRoutes.myList('2'), '/user/2/mylist');
    expect(AppRoutes.collectionFolder('3'), '/collection/3');
    expect(AppRoutes.noticeDetail('4'), '/notice/4');
  });
}
