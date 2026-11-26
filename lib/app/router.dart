import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/login_sheet.dart';
import '../features/account/presentation/account_screen.dart';
import '../features/account/presentation/profile_edit_screen.dart';
import '../features/account/presentation/withdraw_screen.dart';
import '../features/account/presentation/withdrawn_account_screen.dart';
import '../features/collection/presentation/collection_folder_screen.dart';
import '../features/collection/presentation/collection_folders_screen.dart';
import '../features/follow/presentation/followers_screen.dart';
import '../features/follow/presentation/followings_screen.dart';
import '../features/history/presentation/list_history_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/intro/presentation/intro_screen.dart';
import '../features/list_detail/presentation/list_detail_screen.dart';
import '../features/list_editor/presentation/list_create_screen.dart';
import '../features/list_editor/presentation/list_edit_screen.dart';
import '../features/notice/presentation/notice_detail_screen.dart';
import '../features/notice/presentation/notice_list_screen.dart';
import '../features/notification/presentation/notification_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/topics/presentation/topics_screen.dart';
import '../features/user/presentation/user_profile_screen.dart';
import 'app_shell.dart';

/// PLAN §2 의 go_router path. web path 와 1:1 이라 deeplink 매핑이 필요 없다.
abstract final class AppRoutes {
  static const home = '/';
  static const intro = '/intro';
  static const startListy = '/start-listy';
  static const withdrawnAccount = '/withdrawn-account';
  static const listCreate = '/list/create';
  static String listDetail(String listId) => '/list/$listId';
  static String listEdit(String listId) => '/list/$listId/edit';
  static String listHistory(String listId) => '/list/$listId/history';
  static String myList(String userId) => '/user/$userId/mylist';
  static String collaboList(String userId) => '/user/$userId/collabolist';
  static String followers(String userId) => '/user/$userId/followers';
  static String followings(String userId) => '/user/$userId/followings';
  static const search = '/search';
  static const topics = '/topics';
  static const collection = '/collection';
  static String collectionFolder(String folderId) => '/collection/$folderId';
  static const notification = '/notification';
  static const notice = '/notice';
  static String noticeDetail(String noticeId) => '/notice/$noticeId';
  static const account = '/account';
  static const accountProfile = '/account/profile';
  static const accountWithdraw = '/account/withdraw';
  static const login = '/login';
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// auth guard 자리. M1 에서 web `src/middleware.ts` 의 `REQUIRED_TOKEN`
/// (`/account*`, `/start-listy`, `/list/create`, `/collection`, `/notification`)
/// 을 여기서 처리한다. 지금은 아무 곳으로도 보내지 않는다.
String? authRedirect(Ref ref, GoRouterState state) => null;

GoRouter createRouter(Ref ref) => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  redirect: (context, state) => authRedirect(ref, state),
  routes: appRoutes,
);

final routerProvider = Provider<GoRouter>((ref) {
  final router = createRouter(ref);
  ref.onDispose(router.dispose);
  return router;
});

String _param(GoRouterState state, String name) => state.pathParameters[name]!;

final List<RouteBase> appRoutes = [
  // 하단 탭 (web BottomNav: 홈 / 추가 / 내 피드). `/list/create` 는 탭 버튼의
  // 목적지라 shell 안에 두지만, web 처럼 탭 바는 `/` 와 `/mylist` 에서만 보인다.
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) =>
        AppShell(location: state.matchedLocation, child: child),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.listCreate,
        builder: (context, state) => ListCreateScreen(
          title: state.uri.queryParameters['title'],
          category: state.uri.queryParameters['category'],
        ),
      ),
      GoRoute(
        path: '/user/:userId/mylist',
        builder: (context, state) => UserProfileScreen(
          userId: _param(state, 'userId'),
          tab: UserProfileTab.my,
        ),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.intro,
    builder: (context, state) => const IntroScreen(),
  ),
  GoRoute(
    path: AppRoutes.startListy,
    builder: (context, state) => const OnboardingScreen(),
  ),
  GoRoute(
    path: AppRoutes.withdrawnAccount,
    builder: (context, state) => const WithdrawnAccountScreen(),
  ),
  GoRoute(
    path: '/list/:listId',
    builder: (context, state) =>
        ListDetailScreen(listId: _param(state, 'listId')),
    routes: [
      GoRoute(
        path: 'edit',
        builder: (context, state) =>
            ListEditScreen(listId: _param(state, 'listId')),
      ),
      GoRoute(
        path: 'history',
        builder: (context, state) =>
            ListHistoryScreen(listId: _param(state, 'listId')),
      ),
    ],
  ),
  GoRoute(
    path: '/user/:userId/collabolist',
    builder: (context, state) => UserProfileScreen(
      userId: _param(state, 'userId'),
      tab: UserProfileTab.collabo,
    ),
  ),
  GoRoute(
    path: '/user/:userId/followers',
    builder: (context, state) =>
        FollowersScreen(userId: _param(state, 'userId')),
  ),
  GoRoute(
    path: '/user/:userId/followings',
    builder: (context, state) =>
        FollowingsScreen(userId: _param(state, 'userId')),
  ),
  GoRoute(
    path: AppRoutes.search,
    builder: (context, state) => SearchScreen(
      keyword: state.uri.queryParameters['keyword'],
      categoryCode: state.uri.queryParameters['categoryCode'],
      sort: state.uri.queryParameters['sort'],
    ),
  ),
  GoRoute(
    path: AppRoutes.topics,
    builder: (context, state) => const TopicsScreen(),
  ),
  GoRoute(
    path: AppRoutes.collection,
    builder: (context, state) => const CollectionFoldersScreen(),
    routes: [
      GoRoute(
        path: ':folderId',
        builder: (context, state) =>
            CollectionFolderScreen(folderId: _param(state, 'folderId')),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.notification,
    builder: (context, state) => const NotificationScreen(),
  ),
  GoRoute(
    path: AppRoutes.notice,
    builder: (context, state) => const NoticeListScreen(),
    routes: [
      GoRoute(
        path: ':noticeId',
        builder: (context, state) =>
            NoticeDetailScreen(noticeId: _param(state, 'noticeId')),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.account,
    builder: (context, state) => const AccountScreen(),
    routes: [
      GoRoute(
        path: 'profile',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: 'withdraw',
        builder: (context, state) => const WithdrawScreen(),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.login,
    parentNavigatorKey: rootNavigatorKey,
    pageBuilder: (context, state) =>
        DialogPage<void>(key: state.pageKey, child: const LoginSheet()),
  ),
];

/// go_router 에서 dialog 를 route 로 띄우기 위한 Page.
class DialogPage<T> extends Page<T> {
  const DialogPage({super.key, required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder: (context) => child,
  );
}
