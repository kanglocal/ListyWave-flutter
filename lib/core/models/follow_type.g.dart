// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FollowingListType _$FollowingListTypeFromJson(Map<String, dynamic> json) =>
    _FollowingListType(
      followings: (json['followings'] as List<dynamic>)
          .map((e) => UserProfileType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowingListTypeToJson(_FollowingListType instance) =>
    <String, dynamic>{
      'followings': instance.followings.map((e) => e.toJson()).toList(),
    };

_FollowerListType _$FollowerListTypeFromJson(Map<String, dynamic> json) =>
    _FollowerListType(
      followers: (json['followers'] as List<dynamic>)
          .map((e) => UserProfileType.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      cursorId: json['cursorId'] as String?,
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$FollowerListTypeToJson(_FollowerListType instance) =>
    <String, dynamic>{
      'followers': instance.followers.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'cursorId': instance.cursorId,
      'hasNext': instance.hasNext,
    };
