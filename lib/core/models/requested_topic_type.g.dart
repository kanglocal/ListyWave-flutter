// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_topic_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestedTopicType _$RequestedTopicTypeFromJson(Map<String, dynamic> json) =>
    _RequestedTopicType(
      id: (json['id'] as num).toInt(),
      categoryEngName: json['categoryEngName'] as String,
      categoryKorName: json['categoryKorName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerNickname: json['ownerNickname'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$RequestedTopicTypeToJson(_RequestedTopicType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryEngName': instance.categoryEngName,
      'categoryKorName': instance.categoryKorName,
      'title': instance.title,
      'description': instance.description,
      'ownerId': instance.ownerId,
      'ownerNickname': instance.ownerNickname,
      'isAnonymous': instance.isAnonymous,
    };

_TopicsResponseType _$TopicsResponseTypeFromJson(Map<String, dynamic> json) =>
    _TopicsResponseType(
      cursorId: (json['cursorId'] as num?)?.toInt(),
      hasNext: json['hasNext'] as bool,
      topics: (json['topics'] as List<dynamic>)
          .map((e) => RequestedTopicType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicsResponseTypeToJson(_TopicsResponseType instance) =>
    <String, dynamic>{
      'cursorId': instance.cursorId,
      'hasNext': instance.hasNext,
      'topics': instance.topics.map((e) => e.toJson()).toList(),
    };
