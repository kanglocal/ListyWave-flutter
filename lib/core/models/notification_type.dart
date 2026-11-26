// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_type.freezed.dart';
part 'notification_type.g.dart';

// web `src/lib/types/notificationType.ts` · backend `AlarmFindResponse`.
// web 의 `User`/`List`/`Comment`/`Reply`/`Notice` 는 Dart 기본 타입과 겹쳐 `Notification` 을 붙였다.

/// 알림 종류. backend `AlarmType` 에는 web 에 없는 COLLABORATOR, REACTION 이 더 있다.
@JsonEnum()
enum NotificationKind {
  @JsonValue('FOLLOW')
  follow,
  @JsonValue('COLLECT')
  collect,
  @JsonValue('COMMENT')
  comment,
  @JsonValue('REPLY')
  reply,
  @JsonValue('MENTION')
  mention,
  @JsonValue('COLLABORATOR')
  collaborator,
  @JsonValue('NOTICE')
  notice,
  @JsonValue('REACTION')
  reaction,
  unknown,
}

@freezed
abstract class NotificationUser with _$NotificationUser {
  const factory NotificationUser({
    required int id,
    required String nickname,
    required String? profileImageUrl,
  }) = _NotificationUser;

  factory NotificationUser.fromJson(Map<String, dynamic> json) =>
      _$NotificationUserFromJson(json);
}

@freezed
abstract class NotificationList with _$NotificationList {
  const factory NotificationList({required int id, required String title}) =
      _NotificationList;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);
}

/// backend `AlarmFindResponse.MentionDto`. web 은 객체 하나지만 backend 는 목록이다.
@freezed
abstract class NotificationMention with _$NotificationMention {
  const factory NotificationMention({
    required int targetUserId,
    required String targetUserNickname,
  }) = _NotificationMention;

  factory NotificationMention.fromJson(Map<String, dynamic> json) =>
      _$NotificationMentionFromJson(json);
}

/// 댓글/답글 알림의 본문. backend `AlarmFindResponse.CommentDto` / `ReplyDto` (같은 모양).
@freezed
abstract class NotificationComment with _$NotificationComment {
  const factory NotificationComment({
    required int id,
    required String content,
    required List<NotificationMention> mentions,
  }) = _NotificationComment;

  factory NotificationComment.fromJson(Map<String, dynamic> json) =>
      _$NotificationCommentFromJson(json);
}

/// backend `AlarmFindResponse.NoticeDto`. web 의 `createDate`/`content` 는 backend 에 없고
/// backend 는 `createdDate` 를 준다.
@freezed
abstract class NotificationNotice with _$NotificationNotice {
  const factory NotificationNotice({
    required int id,
    required String categoryCode,
    required String categoryViewName,
    required String title,
    required String description,
    required String createdDate,
  }) = _NotificationNotice;

  factory NotificationNotice.fromJson(Map<String, dynamic> json) =>
      _$NotificationNoticeFromJson(json);
}

/// `GET /alarms` 한 개.
@freezed
abstract class NotificationType with _$NotificationType {
  const factory NotificationType({
    required int id,
    required String createdDate,
    required bool checked,
    @JsonKey(unknownEnumValue: NotificationKind.unknown)
    required NotificationKind type,
    required NotificationUser sendUser,
    required NotificationList? list,
    required NotificationComment? comment,
    required NotificationComment? reply,
    required NotificationNotice? notice,
  }) = _NotificationType;

  factory NotificationType.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeFromJson(json);
}

/// `GET /alarms/check-new`. web `getNotificationAllChecked.ts` `alarmCheckType` ·
/// backend `AlarmCheckResponse`.
@freezed
abstract class AlarmCheckType with _$AlarmCheckType {
  const factory AlarmCheckType({required bool isAllChecked}) = _AlarmCheckType;

  factory AlarmCheckType.fromJson(Map<String, dynamic> json) =>
      _$AlarmCheckTypeFromJson(json);
}
