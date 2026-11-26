import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

// web `src/lib/types/user.ts`. `UserOnLoginType` 은 M1 에서 `core/auth/login_response.dart`
// (`LoginResponse`) 로 옮겼다.

/// 유저 검색 결과 한 명. backend `UserSearchResponse.UserDto`.
/// web 은 `UserProfileType` 으로 받지만 backend 는 `isFollowing` 을 더 준다.
@freezed
abstract class SearchedUserType with _$SearchedUserType {
  const factory SearchedUserType({
    required int id,
    required String nickname,
    required String? profileImageUrl,
    required bool isFollowing,
  }) = _SearchedUserType;

  factory SearchedUserType.fromJson(Map<String, dynamic> json) =>
      _$SearchedUserTypeFromJson(json);
}

/// web `UserSearchType` (= `userProfileType.ts` `SearchUserType`) · backend `UserSearchResponse`
/// (`GET /users?search=&size=&page=`).
@freezed
abstract class UserSearchType with _$UserSearchType {
  const factory UserSearchType({
    required List<SearchedUserType> users,
    required int totalCount,
    required bool hasNext,
  }) = _UserSearchType;

  factory UserSearchType.fromJson(Map<String, dynamic> json) =>
      _$UserSearchTypeFromJson(json);
}
