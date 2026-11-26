// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchedUserType _$SearchedUserTypeFromJson(Map<String, dynamic> json) =>
    _SearchedUserType(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      isFollowing: json['isFollowing'] as bool,
    );

Map<String, dynamic> _$SearchedUserTypeToJson(_SearchedUserType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'isFollowing': instance.isFollowing,
    };

_UserSearchType _$UserSearchTypeFromJson(Map<String, dynamic> json) =>
    _UserSearchType(
      users: (json['users'] as List<dynamic>)
          .map((e) => SearchedUserType.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$UserSearchTypeToJson(_UserSearchType instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'hasNext': instance.hasNext,
    };
