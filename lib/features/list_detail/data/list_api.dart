import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/comment_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/models/reaction_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/list/getListDetail.ts`, `deleteList.ts`, `updateVisibilityList.ts`,
/// `_api/comment/*.ts`, `_api/reaction/Reaction.ts`, `_api/collect/collectList.ts`.
class ListDetailApi {
  const ListDetailApi(this._dio);

  final Dio _dio;

  /// 댓글 한 페이지 크기 (web `size: '24'`).
  static const commentPageSize = 24;

  Future<ListDetailType> getListDetail(int listId) async {
    final response = await _dio.get<Object?>('/lists/$listId');
    return ListDetailType.fromJson(asJsonMap(response.data));
  }

  Future<CommentsResponseType> getComments(int listId, {int? cursorId}) async {
    final response = await _dio.get<Object?>(
      '/lists/$listId/comments',
      queryParameters: {'size': commentPageSize, 'cursorId': ?cursorId},
    );
    return CommentsResponseType.fromJson(asJsonMap(response.data));
  }

  /// 리액션 토글. backend `ReactionRequest{reaction}` (204).
  Future<void> react(int listId, ReactionType reaction) => _dio.post<void>(
    '/lists/$listId/reaction',
    data: {'reaction': reactionCode(reaction)},
  );

  /// 콜렉트/취소 토글. backend `FolderSelectionRequest{folderId}` (204).
  /// 취소할 때도 backend 가 `folderRepository.getById(folderId)` 와 소유자 검사를 하므로
  /// 내 폴더 id 하나를 보내야 한다 (`CollectionService.collectOrCancel`).
  Future<void> collect(int listId, {required int folderId}) =>
      _dio.post<void>('/lists/$listId/collect', data: {'folderId': folderId});

  /// 공개/비공개 토글. body 없음 (`ListController.changeVisibility`, 204).
  Future<void> changeVisibility(int listId) =>
      _dio.patch<void>('/lists/$listId/visibility');

  Future<void> deleteList(int listId) => _dio.delete<void>('/lists/$listId');

  /// backend `CommentCreateRequest{content, mentionIds}`. `mentionIds` 는 `@NotNull` 이라
  /// 멘션이 없어도 빈 목록을 보낸다 (web 은 빼고 보내서 400 이 된다).
  Future<void> createComment(
    int listId, {
    required String content,
    required List<int> mentionIds,
  }) => _dio.post<void>(
    '/lists/$listId/comments',
    data: {'content': content, 'mentionIds': mentionIds},
  );

  /// backend `CommentUpdateRequest{content, mentionIds}`.
  Future<void> updateComment(
    int listId,
    int commentId, {
    required String content,
    required List<int> mentionIds,
  }) => _dio.patch<void>(
    '/lists/$listId/comments/$commentId',
    data: {'content': content, 'mentionIds': mentionIds},
  );

  Future<void> deleteComment(int listId, int commentId) =>
      _dio.delete<void>('/lists/$listId/comments/$commentId');

  /// backend `ReplyCreateRequest{content, mentionIds}`. `MentionService.toMentions` 가
  /// `findAllById(mentionIds)` 를 부르므로 null 대신 빈 목록을 보낸다.
  Future<void> createReply(
    int listId,
    int commentId, {
    required String content,
    required List<int> mentionIds,
  }) => _dio.post<void>(
    '/lists/$listId/comments/$commentId/replies',
    data: {'content': content, 'mentionIds': mentionIds},
  );

  /// backend `ReplyUpdateRequest{content, mentionIds}`.
  Future<void> updateReply(
    int listId,
    int commentId,
    int replyId, {
    required String content,
    required List<int> mentionIds,
  }) => _dio.patch<void>(
    '/lists/$listId/comments/$commentId/replies/$replyId',
    data: {'content': content, 'mentionIds': mentionIds},
  );

  Future<void> deleteReply(int listId, int commentId, int replyId) =>
      _dio.delete<void>('/lists/$listId/comments/$commentId/replies/$replyId');
}

/// backend `Reaction` enum 이름.
String reactionCode(ReactionType reaction) => switch (reaction) {
  ReactionType.cool => 'COOL',
  ReactionType.agree => 'AGREE',
  ReactionType.thanks => 'THANKS',
  ReactionType.unknown => throw ArgumentError.value(reaction),
};

final listDetailApiProvider = Provider<ListDetailApi>(
  (ref) => ListDetailApi(ref.watch(dioProvider)),
);
