// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentMentionType _$CommentMentionTypeFromJson(Map<String, dynamic> json) =>
    _CommentMentionType(
      userId: (json['userId'] as num).toInt(),
      userNickname: json['userNickname'] as String,
    );

Map<String, dynamic> _$CommentMentionTypeToJson(_CommentMentionType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userNickname': instance.userNickname,
    };

_ReplyType _$ReplyTypeFromJson(Map<String, dynamic> json) => _ReplyType(
  id: (json['id'] as num).toInt(),
  commentId: (json['commentId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userNickname: json['userNickname'] as String,
  userProfileImageUrl: json['userProfileImageUrl'] as String?,
  content: json['content'] as String,
  createdDate: json['createdDate'] as String,
  updatedDate: json['updatedDate'] as String,
  mentions: (json['mentions'] as List<dynamic>)
      .map((e) => CommentMentionType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReplyTypeToJson(_ReplyType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commentId': instance.commentId,
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'mentions': instance.mentions.map((e) => e.toJson()).toList(),
    };

_CommentType _$CommentTypeFromJson(Map<String, dynamic> json) => _CommentType(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userNickname: json['userNickname'] as String,
  userProfileImageUrl: json['userProfileImageUrl'] as String?,
  content: json['content'] as String,
  createdDate: json['createdDate'] as String,
  updatedDate: json['updatedDate'] as String,
  isDeleted: json['isDeleted'] as bool,
  replies: (json['replies'] as List<dynamic>)
      .map((e) => ReplyType.fromJson(e as Map<String, dynamic>))
      .toList(),
  mentions: (json['mentions'] as List<dynamic>)
      .map((e) => CommentMentionType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CommentTypeToJson(_CommentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'isDeleted': instance.isDeleted,
      'replies': instance.replies.map((e) => e.toJson()).toList(),
      'mentions': instance.mentions.map((e) => e.toJson()).toList(),
    };

_CommentsResponseType _$CommentsResponseTypeFromJson(
  Map<String, dynamic> json,
) => _CommentsResponseType(
  totalCount: (json['totalCount'] as num).toInt(),
  cursorId: (json['cursorId'] as num?)?.toInt(),
  hasNext: json['hasNext'] as bool,
  comments: (json['comments'] as List<dynamic>)
      .map((e) => CommentType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CommentsResponseTypeToJson(
  _CommentsResponseType instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'cursorId': instance.cursorId,
  'hasNext': instance.hasNext,
  'comments': instance.comments.map((e) => e.toJson()).toList(),
};

_CollaboratorType _$CollaboratorTypeFromJson(Map<String, dynamic> json) =>
    _CollaboratorType(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$CollaboratorTypeToJson(_CollaboratorType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };
