import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_type.freezed.dart';
part 'comment_type.g.dart';

// web `src/lib/types/commentType.ts` · backend `CommentFindResponse`.

/// 댓글/답글의 멘션. backend `CommentFindResponse.MentionDto` (web 에 없음).
/// 탈퇴한 사용자면 `userId` 0, `userNickname` "withdrawer" 다.
@freezed
abstract class CommentMentionType with _$CommentMentionType {
  const factory CommentMentionType({
    required int userId,
    required String userNickname,
  }) = _CommentMentionType;

  factory CommentMentionType.fromJson(Map<String, dynamic> json) =>
      _$CommentMentionTypeFromJson(json);
}

/// backend `CommentFindResponse.ReplyDto`.
@freezed
abstract class ReplyType with _$ReplyType {
  const factory ReplyType({
    required int id,
    required int commentId,
    required int userId,
    required String userNickname,
    required String? userProfileImageUrl,
    required String content,
    required String createdDate,
    required String updatedDate,
    required List<CommentMentionType> mentions,
  }) = _ReplyType;

  factory ReplyType.fromJson(Map<String, dynamic> json) =>
      _$ReplyTypeFromJson(json);
}

/// backend `CommentFindResponse.CommentDto`. web 은 `replies` 를 nullable 로 두지만
/// backend 는 항상 목록을 준다.
@freezed
abstract class CommentType with _$CommentType {
  const factory CommentType({
    required int id,
    required int userId,
    required String userNickname,
    required String? userProfileImageUrl,
    required String content,
    required String createdDate,
    required String updatedDate,
    required bool isDeleted,
    required List<ReplyType> replies,
    required List<CommentMentionType> mentions,
  }) = _CommentType;

  factory CommentType.fromJson(Map<String, dynamic> json) =>
      _$CommentTypeFromJson(json);
}

/// `GET /lists/{listId}/comments` 응답 (web 은 타입 없음). backend `CommentFindResponse`.
@freezed
abstract class CommentsResponseType with _$CommentsResponseType {
  const factory CommentsResponseType({
    required int totalCount,
    required int? cursorId,
    required bool hasNext,
    required List<CommentType> comments,
  }) = _CommentsResponseType;

  factory CommentsResponseType.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseTypeFromJson(json);
}

/// 리스트 협업자. backend `ListDetailResponse.CollaboratorResponse` (`id` 는 항상 있다).
@freezed
abstract class CollaboratorType with _$CollaboratorType {
  const factory CollaboratorType({
    required int id,
    required String nickname,
    required String? profileImageUrl,
  }) = _CollaboratorType;

  factory CollaboratorType.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorTypeFromJson(json);
}
