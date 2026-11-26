// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationUser _$NotificationUserFromJson(Map<String, dynamic> json) =>
    _NotificationUser(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$NotificationUserToJson(_NotificationUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };

_NotificationList _$NotificationListFromJson(Map<String, dynamic> json) =>
    _NotificationList(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$NotificationListToJson(_NotificationList instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

_NotificationMention _$NotificationMentionFromJson(Map<String, dynamic> json) =>
    _NotificationMention(
      targetUserId: (json['targetUserId'] as num).toInt(),
      targetUserNickname: json['targetUserNickname'] as String,
    );

Map<String, dynamic> _$NotificationMentionToJson(
  _NotificationMention instance,
) => <String, dynamic>{
  'targetUserId': instance.targetUserId,
  'targetUserNickname': instance.targetUserNickname,
};

_NotificationComment _$NotificationCommentFromJson(Map<String, dynamic> json) =>
    _NotificationComment(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      mentions: (json['mentions'] as List<dynamic>)
          .map((e) => NotificationMention.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationCommentToJson(
  _NotificationComment instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'mentions': instance.mentions.map((e) => e.toJson()).toList(),
};

_NotificationNotice _$NotificationNoticeFromJson(Map<String, dynamic> json) =>
    _NotificationNotice(
      id: (json['id'] as num).toInt(),
      categoryCode: json['categoryCode'] as String,
      categoryViewName: json['categoryViewName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$NotificationNoticeToJson(_NotificationNotice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryCode': instance.categoryCode,
      'categoryViewName': instance.categoryViewName,
      'title': instance.title,
      'description': instance.description,
      'createdDate': instance.createdDate,
    };

_NotificationType _$NotificationTypeFromJson(
  Map<String, dynamic> json,
) => _NotificationType(
  id: (json['id'] as num).toInt(),
  createdDate: json['createdDate'] as String,
  checked: json['checked'] as bool,
  type: $enumDecode(
    _$NotificationKindEnumMap,
    json['type'],
    unknownValue: NotificationKind.unknown,
  ),
  sendUser: NotificationUser.fromJson(json['sendUser'] as Map<String, dynamic>),
  list: json['list'] == null
      ? null
      : NotificationList.fromJson(json['list'] as Map<String, dynamic>),
  comment: json['comment'] == null
      ? null
      : NotificationComment.fromJson(json['comment'] as Map<String, dynamic>),
  reply: json['reply'] == null
      ? null
      : NotificationComment.fromJson(json['reply'] as Map<String, dynamic>),
  notice: json['notice'] == null
      ? null
      : NotificationNotice.fromJson(json['notice'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NotificationTypeToJson(_NotificationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'checked': instance.checked,
      'type': _$NotificationKindEnumMap[instance.type]!,
      'sendUser': instance.sendUser.toJson(),
      'list': instance.list?.toJson(),
      'comment': instance.comment?.toJson(),
      'reply': instance.reply?.toJson(),
      'notice': instance.notice?.toJson(),
    };

const _$NotificationKindEnumMap = {
  NotificationKind.follow: 'FOLLOW',
  NotificationKind.collect: 'COLLECT',
  NotificationKind.comment: 'COMMENT',
  NotificationKind.reply: 'REPLY',
  NotificationKind.mention: 'MENTION',
  NotificationKind.collaborator: 'COLLABORATOR',
  NotificationKind.notice: 'NOTICE',
  NotificationKind.reaction: 'REACTION',
  NotificationKind.unknown: 'unknown',
};

_AlarmCheckType _$AlarmCheckTypeFromJson(Map<String, dynamic> json) =>
    _AlarmCheckType(isAllChecked: json['isAllChecked'] as bool);

Map<String, dynamic> _$AlarmCheckTypeToJson(_AlarmCheckType instance) =>
    <String, dynamic>{'isAllChecked': instance.isAllChecked};
