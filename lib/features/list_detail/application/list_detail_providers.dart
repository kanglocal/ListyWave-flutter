import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/comment_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/models/reaction_type.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../../collection/application/collection_providers.dart';
import '../../user/application/user_providers.dart';
import '../data/list_api.dart';

/// web QUERY_KEYS.getListDetail. 로그인 사용자에 따라 isCollected/isFollowing/reactions 가
/// 달라지므로 [currentUserIdProvider] 를 watch 한다.
///
/// 리액션/콜렉트/공개 여부는 낙관적으로 바꾼다 (PLAN §5.2). 값을 먼저 바꾸고, API 가 실패하면
/// 이전 값으로 되돌린 뒤 오류를 다시 던진다. 성공하면 서버 값으로 다시 읽는다.
class ListDetailNotifier extends AsyncNotifier<ListDetailType> {
  ListDetailNotifier(this.listId);

  final int listId;

  /// 진행 중인 변경. 같은 종류를 두 번 누르면 무시한다.
  final Set<String> _pending = {};

  @override
  Future<ListDetailType> build() {
    ref.watch(currentUserIdProvider);
    return ref.watch(listDetailApiProvider).getListDetail(listId);
  }

  ListDetailApi get _api => ref.read(listDetailApiProvider);

  /// web `Footer.tsx` reactMutation 의 onMutate/onError 를 제대로 구현한 것.
  Future<void> toggleReaction(ReactionType type) => _optimistic(
    'reaction.$type',
    (list) => list.copyWith(reactions: toggledReactions(list.reactions, type)),
    () => _api.react(listId, type),
  );

  /// 콜렉트한다 (`{folderId}`). 성공하면 [folderId] 를 다음 기본 폴더로 기억한다.
  Future<void> collect(int folderId) async {
    await _optimistic(
      'collect',
      (list) => list.copyWith(isCollected: true),
      () => _api.collect(listId, folderId: folderId),
    );
    await ref.read(lastCollectFolderStoreProvider).write(folderId);
    ref.invalidate(foldersProvider);
  }

  /// 콜렉트를 취소한다. backend 는 취소에도 내 폴더 id 를 요구하므로 마지막으로 쓴 폴더
  /// (없으면 첫 폴더) 를 보낸다. 폴더가 하나도 없으면 [StateError] 다.
  Future<void> uncollect() => _optimistic(
    'collect',
    (list) => list.copyWith(isCollected: false),
    () async {
      final folders = await ref.read(foldersProvider.future);
      final lastUsed = await ref.read(lastCollectFolderStoreProvider).read();
      final folderId = preferredFolderId(folders, lastUsed);
      if (folderId == null) throw StateError('no collection folder');
      await _api.collect(listId, folderId: folderId);
      ref.invalidate(foldersProvider);
    },
  );

  /// 리스트 주인의 공개/비공개 토글.
  Future<void> toggleVisibility() async {
    await _optimistic(
      'visibility',
      (list) => list.copyWith(isPublic: !list.isPublic),
      () => _api.changeVisibility(listId),
    );
    _invalidateOwnerLists();
  }

  /// 리스트를 지운다. 이 provider 는 화면을 떠날 때 버려진다.
  Future<void> delete() async {
    await _api.deleteList(listId);
    _invalidateOwnerLists();
  }

  /// 마이리스트의 공개 여부/목록이 바뀐다. 모든 탭·카테고리를 다시 읽게 family 째 버린다.
  void _invalidateOwnerLists() => ref.invalidate(userListsProvider);

  Future<void> _optimistic(
    String key,
    ListDetailType Function(ListDetailType list) update,
    Future<void> Function() request,
  ) async {
    final previous = state.value;
    if (previous == null || !_pending.add(key)) return;
    state = AsyncData(update(previous));
    try {
      await request();
    } catch (_) {
      state = AsyncData(previous);
      rethrow;
    } finally {
      _pending.remove(key);
    }
    ref.invalidateSelf();
  }
}

final listDetailProvider = AsyncNotifierProvider.autoDispose
    .family<ListDetailNotifier, ListDetailType, int>(ListDetailNotifier.new);

/// [type] 리액션의 isReacted 를 뒤집는다. count 는 주인에게만 오므로 있을 때만 고친다.
/// 목록에 없는 리액션이면 새로 넣는다.
List<Reaction> toggledReactions(List<Reaction> reactions, ReactionType type) {
  if (!reactions.any((r) => r.reaction == type)) {
    return [
      ...reactions,
      Reaction(reaction: type, count: null, isReacted: true),
    ];
  }
  return [
    for (final r in reactions)
      if (r.reaction != type)
        r
      else
        r.copyWith(
          isReacted: !r.isReacted,
          count: switch (r.count) {
            null => null,
            final c => r.isReacted ? (c - 1).clamp(0, c) : c + 1,
          },
        ),
  ];
}

/// web QUERY_KEYS.getComments (infinite, size 24).
///
/// 작성/수정/삭제는 성공하면 web 처럼 목록을 다시 읽는다 (`invalidateQueries`). 상세의
/// 댓글 수와 최신 댓글도 바뀌므로 [listDetailProvider] 도 다시 읽는다.
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

  ListDetailApi get _api => ref.read(listDetailApiProvider);

  Future<void> createComment(String content, List<int> mentionIds) => _mutate(
    () => _api.createComment(listId, content: content, mentionIds: mentionIds),
  );

  Future<void> updateComment(
    int commentId,
    String content,
    List<int> mentionIds,
  ) => _mutate(
    () => _api.updateComment(
      listId,
      commentId,
      content: content,
      mentionIds: mentionIds,
    ),
  );

  Future<void> deleteComment(int commentId) =>
      _mutate(() => _api.deleteComment(listId, commentId));

  Future<void> createReply(
    int commentId,
    String content,
    List<int> mentionIds,
  ) => _mutate(
    () => _api.createReply(
      listId,
      commentId,
      content: content,
      mentionIds: mentionIds,
    ),
  );

  Future<void> updateReply(
    int commentId,
    int replyId,
    String content,
    List<int> mentionIds,
  ) => _mutate(
    () => _api.updateReply(
      listId,
      commentId,
      replyId,
      content: content,
      mentionIds: mentionIds,
    ),
  );

  Future<void> deleteReply(int commentId, int replyId) =>
      _mutate(() => _api.deleteReply(listId, commentId, replyId));

  Future<void> _mutate(Future<void> Function() request) async {
    await request();
    ref
      ..invalidateSelf()
      ..invalidate(listDetailProvider(listId));
  }
}

final commentsProvider = AsyncNotifierProvider.autoDispose
    .family<CommentsNotifier, PageState<CommentType, int>, int>(
      CommentsNotifier.new,
    );
