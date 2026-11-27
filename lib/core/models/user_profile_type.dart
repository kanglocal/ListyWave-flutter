import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_type.freezed.dart';
part 'user_profile_type.g.dart';

/// web `src/lib/types/userProfileType.ts` `UserProfileType`.
/// backend `UsersRecommendedResponse`, `FollowersResponse.FollowerInfo`,
/// `FollowingsResponse.FollowingInfo`, `UserInfo` 가 같은 모양이다.
@freezed
abstract class UserProfileType with _$UserProfileType {
  const factory UserProfileType({
    required int id,
    required String? profileImageUrl,
    required String nickname,
  }) = _UserProfileType;

  factory UserProfileType.fromJson(Map<String, dynamic> json) =>
      _$UserProfileTypeFromJson(json);
}

/// web `UserProfilesType` · backend `AllUserResponse`.
@freezed
abstract class UserProfilesType with _$UserProfilesType {
  const factory UserProfilesType({required List<UserProfileType> userInfos}) =
      _UserProfilesType;

  factory UserProfilesType.fromJson(Map<String, dynamic> json) =>
      _$UserProfilesTypeFromJson(json);
}

/// web `UserType` · backend `UserInfoResponse` (`GET /users/{userId}`).
@freezed
abstract class UserType with _$UserType {
  const factory UserType({
    required int id,
    required String? backgroundImageUrl,
    required String? profileImageUrl,
    required String nickname,
    required String? description,
    required int followingCount,
    required int followerCount,
    required bool isFollowed,
    required bool isOwner,
  }) = _UserType;

  factory UserType.fromJson(Map<String, dynamic> json) =>
      _$UserTypeFromJson(json);
}

/// web `DefaultImagesType` 한 개 · backend `DefaultProfileImageUrlResponse`,
/// `DefaultBackgroundImageUrlResponse`.
@freezed
abstract class DefaultImageType with _$DefaultImageType {
  const factory DefaultImageType({
    required String name,
    required String imageUrl,
  }) = _DefaultImageType;

  factory DefaultImageType.fromJson(Map<String, dynamic> json) =>
      _$DefaultImageTypeFromJson(json);
}
