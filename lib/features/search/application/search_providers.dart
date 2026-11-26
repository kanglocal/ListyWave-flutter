import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/list_type.dart';
import '../../../core/models/user.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../data/search_api.dart';

/// [searchListsProvider] 의 family 인자.
typedef SearchListsQuery = ({
  String keyword,
  SearchSort sort,
  String categoryCode,
});

/// web QUERY_KEYS.searchListResult (infinite, size 6, cursorId).
class SearchListsNotifier extends PaginatedNotifier<SearchListType, int> {
  SearchListsNotifier(this.query);

  final SearchListsQuery query;

  @override
  Future<CursorPage<SearchListType, int>> fetchPage(int? cursor) async {
    final response = await ref
        .read(searchApiProvider)
        .getSearchListResult(
          keyword: query.keyword,
          sort: query.sort,
          categoryCode: query.categoryCode,
          cursorId: cursor,
        );
    return CursorPage(
      items: response.resultLists,
      nextCursor: response.hasNext ? response.cursorId : null,
      hasNext: response.hasNext,
      totalCount: response.totalCount,
    );
  }
}

final searchListsProvider = AsyncNotifierProvider.autoDispose
    .family<
      SearchListsNotifier,
      PageState<SearchListType, int>,
      SearchListsQuery
    >(SearchListsNotifier.new);

/// web QUERY_KEYS.searchUserResult (page 기반, size 3). cursor 는 다음 page 번호다.
/// web 은 다음 page 를 `allPages.length + 1` 로 계산해 page 1 을 건너뛴다. 앱은 0, 1, 2… 로 간다.
/// 로그인 사용자에 따라 `isFollowing` 이 달라진다.
class SearchUsersNotifier extends PaginatedNotifier<SearchedUserType, int> {
  SearchUsersNotifier(this.keyword);

  final String keyword;

  @override
  Future<PageState<SearchedUserType, int>> build() {
    ref.watch(currentUserIdProvider);
    return super.build();
  }

  @override
  Future<CursorPage<SearchedUserType, int>> fetchPage(int? cursor) async {
    final page = cursor ?? 0;
    final response = await ref
        .read(searchApiProvider)
        .getSearchUserResult(keyword: keyword, page: page);
    return CursorPage(
      items: response.users,
      nextCursor: response.hasNext ? page + 1 : null,
      hasNext: response.hasNext,
      totalCount: response.totalCount,
    );
  }
}

final searchUsersProvider = AsyncNotifierProvider.autoDispose
    .family<SearchUsersNotifier, PageState<SearchedUserType, int>, String>(
      SearchUsersNotifier.new,
    );
