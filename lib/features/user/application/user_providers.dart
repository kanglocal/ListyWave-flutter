import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/list_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/pagination/cache_for.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../data/user_api.dart';

/// web QUERY_KEYS.userOne. isOwner/isFollowed 가 로그인 사용자에 따라 달라진다.
final userProvider = FutureProvider.autoDispose.family<UserType, int>((
  ref,
  userId,
) {
  ref.watch(currentUserIdProvider);
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(userApiProvider).getUserOne(userId);
});

/// [userListsProvider] 의 family 인자.
typedef UserListsQuery = ({int userId, UserListType type, String category});

/// web `Content.tsx` QUERY_KEYS.getAllList (infinite, staleTime 5분).
class UserListsNotifier extends PaginatedNotifier<ListType, String> {
  UserListsNotifier(this.query);

  final UserListsQuery query;

  @override
  Future<PageState<ListType, String>> build() {
    ref.watch(currentUserIdProvider);
    ref.cacheFor(const Duration(minutes: 5));
    return super.build();
  }

  @override
  Future<CursorPage<ListType, String>> fetchPage(String? cursor) async {
    final response = await ref
        .read(userApiProvider)
        .getAllList(
          query.userId,
          type: query.type,
          category: query.category,
          cursorUpdatedDate: cursor,
        );
    return CursorPage(
      items: response.feedLists,
      nextCursor: response.hasNext ? response.cursorUpdatedDate : null,
      hasNext: response.hasNext,
    );
  }
}

final userListsProvider = AsyncNotifierProvider.autoDispose
    .family<UserListsNotifier, PageState<ListType, String>, UserListsQuery>(
      UserListsNotifier.new,
    );

/// web QUERY_KEYS.getDefaultProfileImages. 서버 설정이라 앱이 살아 있는 동안 한 번만 부른다.
final defaultProfileImagesProvider = FutureProvider<List<DefaultImageType>>(
  (ref) => ref.watch(userApiProvider).getDefaultProfileImages(),
);

/// web QUERY_KEYS.getDefaultBackgroundImages.
final defaultBackgroundImagesProvider = FutureProvider<List<DefaultImageType>>(
  (ref) => ref.watch(userApiProvider).getDefaultBackgroundImages(),
);
