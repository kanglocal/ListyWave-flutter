import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/comment_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../data/list_api.dart';

/// web QUERY_KEYS.getListDetail. 로그인 사용자에 따라 isCollected/isFollowing/reactions 가
/// 달라지므로 [currentUserIdProvider] 를 watch 한다.
final listDetailProvider = FutureProvider.autoDispose
    .family<ListDetailType, int>((ref, listId) {
      ref.watch(currentUserIdProvider);
      return ref.watch(listDetailApiProvider).getListDetail(listId);
    });

/// web QUERY_KEYS.getComments (infinite, size 24).
class CommentsNotifier extends PaginatedNotifier<CommentType, int> {
  CommentsNotifier(this.listId);

  final int listId;

  @override
  Future<CursorPage<CommentType, int>> fetchPage(int? cursor) async {
    final response = await ref
        .read(listDetailApiProvider)
        .getComments(listId, cursorId: cursor);
    return CursorPage(
      items: response.comments,
      nextCursor: response.hasNext ? response.cursorId : null,
      hasNext: response.hasNext,
      totalCount: response.totalCount,
    );
  }
}

final commentsProvider = AsyncNotifierProvider.autoDispose
    .family<CommentsNotifier, PageState<CommentType, int>, int>(
      CommentsNotifier.new,
    );
