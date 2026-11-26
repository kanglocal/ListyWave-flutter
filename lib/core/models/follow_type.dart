import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_profile_type.dart';

part 'follow_type.freezed.dart';
part 'follow_type.g.dart';

/// web `src/lib/types/followType.ts` · backend `FollowingsResponse`.
@freezed
abstract class FollowingListType with _$FollowingListType {
  const factory FollowingListType({required List<UserProfileType> followings}) =
      _FollowingListType;

  factory FollowingListType.fromJson(Map<String, dynamic> json) =>
      _$FollowingListTypeFromJson(json);
}

/// backend `FollowersResponse`. web 은 `cursorId: number` 지만 backend 는 마지막 사용자의
/// nickname(String) 이고, 팔로워가 없으면 null 이다.
@freezed
abstract class FollowerListType with _$FollowerListType {
  const factory FollowerListType({
    required List<UserProfileType> followers,
    required int totalCount,
    required String? cursorId,
    required bool hasNext,
  }) = _FollowerListType;

  factory FollowerListType.fromJson(Map<String, dynamic> json) =>
      _$FollowerListTypeFromJson(json);
}
