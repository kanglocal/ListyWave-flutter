import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/home_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../data/home_api.dart';

/// 홈 탭 (web `src/store/useTab.ts`).
enum HomeTab { recommendation, recent, following }

class HomeTabNotifier extends Notifier<HomeTab> {
  @override
  HomeTab build() => HomeTab.recommendation;

  void select(HomeTab tab) => state = tab;
}

final homeTabProvider = NotifierProvider<HomeTabNotifier, HomeTab>(
  HomeTabNotifier.new,
);

/// web QUERY_KEYS.getHomeRecommendedLists.
final homeRecommendedListsProvider =
    FutureProvider.autoDispose<List<HomeRecommendedListType>>(
      (ref) => ref.watch(homeApiProvider).getHomeRecommendedLists(),
    );

/// web QUERY_KEYS.getRecommendedTopics.
final recommendedTopicsProvider =
    FutureProvider.autoDispose<List<RecommendedTopicType>>(
      (ref) => ref.watch(homeApiProvider).getRecommendedTopics(),
    );

/// web QUERY_KEYS.getRecommendedUsers. 로그인하면 backend 가 나와 팔로우 중인 사람을 뺀다.
final recommendedUsersProvider =
    FutureProvider.autoDispose<List<UserProfileType>>((ref) {
      ref.watch(currentUserIdProvider);
      return ref.watch(homeApiProvider).getRecommendedUsers();
    });

CursorPage<ListRecommendationType, String> _feedPage(FeedListsType response) =>
    CursorPage(
      items: response.lists,
      nextCursor: response.hasNext ? response.cursorUpdatedDate : null,
      hasNext: response.hasNext,
    );

/// 최신 피드 (web `FeedLists` tab=recent). family 인자는 category engName 이다.
class RecentFeedNotifier
    extends PaginatedNotifier<ListRecommendationType, String> {
  RecentFeedNotifier(this.category);

  final String category;

  @override
  Future<CursorPage<ListRecommendationType, String>> fetchPage(
    String? cursor,
  ) async => _feedPage(
    await ref
        .read(homeApiProvider)
        .getRecentLists(cursorUpdatedDate: cursor, category: category),
  );
}

final recentFeedProvider = AsyncNotifierProvider.autoDispose
    .family<
      RecentFeedNotifier,
      PageState<ListRecommendationType, String>,
      String
    >(RecentFeedNotifier.new);

/// 팔로잉 피드 (web `FeedLists` tab=following). 로그인 사용자가 바뀌면 다시 부른다.
class FollowingFeedNotifier
    extends PaginatedNotifier<ListRecommendationType, String> {
  @override
  Future<PageState<ListRecommendationType, String>> build() {
    ref.watch(currentUserIdProvider);
    return super.build();
  }

  @override
  Future<CursorPage<ListRecommendationType, String>> fetchPage(
    String? cursor,
  ) async => _feedPage(
    await ref
        .read(homeApiProvider)
        .getFollowingLists(cursorUpdatedDate: cursor),
  );
}

final followingFeedProvider =
    AsyncNotifierProvider.autoDispose<
      FollowingFeedNotifier,
      PageState<ListRecommendationType, String>
    >(FollowingFeedNotifier.new);
