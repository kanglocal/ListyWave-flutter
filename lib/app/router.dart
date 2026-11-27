import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/auth_controller.dart';
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

/// web `src/middleware.ts` 의 `REQUIRED_TOKEN`. web 은 `/collection` 만 정확히 비교하지만
/// 앱은 폴더 상세(`/collection/:id`)도 막는다.
bool isAuthRequired(String path) =>
    path == AppRoutes.startListy ||
    path == AppRoutes.listCreate ||
    path == AppRoutes.notification ||
    [
      AppRoutes.account,
      AppRoutes.collection,
    ].any((p) => path == p || path.startsWith('$p/'));

bool _needsLogin(Ref ref, String path) =>
    ref.read(authControllerProvider).status == AuthStatus.loggedOut &&
    isAuthRequired(path);

/// 로그인 뒤 [from] 으로 돌아오는 로그인 sheet 위치.
String loginLocation(Uri from) => Uri(
  path: AppRoutes.login,
  queryParameters: {'from': from.toString()},
).toString();

/// 앱 안에서 [isAuthRequired] 경로로 가려 하면 이동을 막고, 지금 화면 위에 로그인 sheet 를
/// 띄운다 (web 이 `/?loginRequired=true` 로 홈 위에 모달을 띄우는 것과 같은 효과).
/// 지금 화면도 보호 경로면 (세션 만료로 refresh 된 경우) [authRedirect] 에 맡긴다.
FutureOr<OnEnterResult> authOnEnter(
  Ref ref,
  GoRouterState current,
  GoRouterState next,
) {
  if (!_needsLogin(ref, next.uri.path) || isAuthRequired(current.uri.path)) {
    return const Allow();
  }
  // 막힌 parse 도중 router.push 를 하면 Router 가 그 결과를 버린다. 그래서 route 가 아닌
  // dialog 로 root navigator 에 바로 올린다. Future 는 sheet 가 닫힐 때 끝나므로 기다리지 않는다.
  return Block.then(() {
    final navigator = rootNavigatorKey.currentState;
    if (navigator == null) return;
    unawaited(
      navigator.push(
        DialogRoute<void>(
          context: navigator.context,
          builder: (_) => LoginSheet(from: next.uri.toString()),
        ),
      ),
    );
  });
}

/// 로그아웃 상태로 보호 경로에 남게 되면 (세션 만료, 보호 경로 deep link) 로그인 sheet 로 보내고
/// 돌아올 위치를 `from` 으로 넘긴다. 세션 확인 중(unknown)에는 막지 않는다.
/// 확인이 끝나 로그아웃 상태가 되면 refreshListenable 로 다시 돈다.
///
/// 사용자가 직접 로그아웃/탈퇴했으면 다시 로그인하라고 하지 않고 홈으로 보낸다
/// (web `LogoutModal`, `WithdrawalButton` 의 `router.push('/')`).
String? authRedirect(Ref ref, GoRouterState state) {
  if (!_needsLogin(ref, state.uri.path)) return null;
  final reason = ref.read(authControllerProvider).reason;
  if (reason == LogoutReason.user || reason == LogoutReason.withdraw) {
    return AppRoutes.home;
  }
  return loginLocation(state.uri);
}

GoRouter createRouter(Ref ref) {
  // guard 결과가 바뀌는 것은 로그아웃 상태가 될 때뿐이다. 로그인 때 refresh 하면
  // LoginSheet 의 pop 과 경쟁해 sheet 가 남으므로 로그아웃으로 바뀔 때만 알린다.
  final loggedOut = _RouterRefresh();
  ref.listen(
    authControllerProvider.select((s) => s.status == AuthStatus.loggedOut),
    (_, isLoggedOut) {
      if (isLoggedOut) loggedOut.notify();
    },
  );
  ref.onDispose(loggedOut.dispose);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    refreshListenable: loggedOut,
    onEnter: (context, current, next, router) =>
        authOnEnter(ref, current, next),
    redirect: (context, state) => authRedirect(ref, state),
    routes: appRoutes,
  );
}

class _RouterRefresh extends ChangeNotifier {
  void notify() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = createRouter(ref);
  ref.onDispose(router.dispose);
  return router;
});

String _param(GoRouterState state, String name) => state.pathParameters[name]!;

final List<RouteBase> appRoutes = [
  // 하단 탭 (web BottomNav: 홈 / 추가 / 내 피드). web 처럼 탭 바는 `/` 와 `/mylist` 에서만
  // 보인다. `/mylist` 는 아래에서 따로 AppShell 로 감싼다.
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) =>
        AppShell(location: state.matchedLocation, child: child),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  ),
  // 리스트 만들기는 탭 바가 없는 화면이라 shell 밖에 둔다. 상세·topics 등 root 화면에서
  // `/list/create?title=&category=` 를 push 하면 shell navigator 가 stack 에 두 번 생겨
  // Navigator 가 깨지기 때문이다 (아래 `/mylist` 설명과 같은 이유).
  GoRoute(
    path: AppRoutes.listCreate,
    builder: (context, state) => ListCreateScreen(
      title: state.uri.queryParameters['title'],
      category: state.uri.queryParameters['category'],
    ),
  ),
  // 마이리스트도 web 처럼 하단 탭을 보이지만 ShellRoute 밖에 둔다. 리스트 상세·댓글·팔로워
  // 목록 등 root 화면에서 다른 사람의 마이리스트를 push 하면, shell navigator(GlobalKey) 가
  // stack 에 두 번 생겨 Navigator 가 깨지기 때문이다. 하단 탭은 같은 AppShell 로 감싼다.
  GoRoute(
    path: '/user/:userId/mylist',
    builder: (context, state) => AppShell(
      location: state.matchedLocation,
      child: UserProfileScreen(
        userId: _param(state, 'userId'),
        tab: UserProfileTab.my,
      ),
    ),
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
    pageBuilder: (context, state) => DialogPage<void>(
      key: state.pageKey,
      child: LoginSheet(from: state.uri.queryParameters['from']),
    ),
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
