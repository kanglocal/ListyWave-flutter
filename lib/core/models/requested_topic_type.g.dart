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
      categoryCode: json['categoryCode'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: json['createdDate'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerNickname: json['ownerNickname'] as String,
      isAnonymous: json['isAnonymous'] as bool,
      isExposed: json['isExposed'] as bool,
    );

Map<String, dynamic> _$RequestedTopicTypeToJson(_RequestedTopicType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryEngName': instance.categoryEngName,
      'categoryKorName': instance.categoryKorName,
      'categoryCode': instance.categoryCode,
      'title': instance.title,
      'description': instance.description,
      'createdDate': instance.createdDate,
      'ownerId': instance.ownerId,
      'ownerNickname': instance.ownerNickname,
      'isAnonymous': instance.isAnonymous,
      'isExposed': instance.isExposed,
    };

_TopicsResponseType _$TopicsResponseTypeFromJson(Map<String, dynamic> json) =>
    _TopicsResponseType(
      hasNext: json['hasNext'] as bool,
      totalCount: (json['totalCount'] as num).toInt(),
      cursorId: (json['cursorId'] as num?)?.toInt(),
      topics: (json['topics'] as List<dynamic>)
          .map((e) => RequestedTopicType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicsResponseTypeToJson(_TopicsResponseType instance) =>
    <String, dynamic>{
      'hasNext': instance.hasNext,
      'totalCount': instance.totalCount,
      'cursorId': instance.cursorId,
      'topics': instance.topics.map((e) => e.toJson()).toList(),
    };
