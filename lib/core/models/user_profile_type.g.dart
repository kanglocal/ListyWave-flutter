// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileType _$UserProfileTypeFromJson(Map<String, dynamic> json) =>
    _UserProfileType(
      id: (json['id'] as num).toInt(),
      profileImageUrl: json['profileImageUrl'] as String?,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserProfileTypeToJson(_UserProfileType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileImageUrl': instance.profileImageUrl,
      'nickname': instance.nickname,
    };

_UserProfilesType _$UserProfilesTypeFromJson(Map<String, dynamic> json) =>
    _UserProfilesType(
      userInfos: (json['userInfos'] as List<dynamic>)
          .map((e) => UserProfileType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserProfilesTypeToJson(_UserProfilesType instance) =>
    <String, dynamic>{
      'userInfos': instance.userInfos.map((e) => e.toJson()).toList(),
    };

_UserType _$UserTypeFromJson(Map<String, dynamic> json) => _UserType(
  id: (json['id'] as num).toInt(),
  backgroundImageUrl: json['backgroundImageUrl'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
  nickname: json['nickname'] as String,
  description: json['description'] as String?,
  followingCount: (json['followingCount'] as num).toInt(),
  followerCount: (json['followerCount'] as num).toInt(),
  isFollowed: json['isFollowed'] as bool,
  isOwner: json['isOwner'] as bool,
);

Map<String, dynamic> _$UserTypeToJson(_UserType instance) => <String, dynamic>{
  'id': instance.id,
  'backgroundImageUrl': instance.backgroundImageUrl,
  'profileImageUrl': instance.profileImageUrl,
  'nickname': instance.nickname,
  'description': instance.description,
  'followingCount': instance.followingCount,
  'followerCount': instance.followerCount,
  'isFollowed': instance.isFollowed,
  'isOwner': instance.isOwner,
};

_DefaultImageType _$DefaultImageTypeFromJson(Map<String, dynamic> json) =>
    _DefaultImageType(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$DefaultImageTypeToJson(_DefaultImageType instance) =>
    <String, dynamic>{'name': instance.name, 'imageUrl': instance.imageUrl};
