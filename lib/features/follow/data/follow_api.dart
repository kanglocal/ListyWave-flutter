import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/follow_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/follow/*.ts` (목록 조회, 팔로우/언팔로우, 팔로워 삭제).
class FollowApi {
  const FollowApi(this._dio);

  final Dio _dio;

  Future<FollowerListType> getFollowerList(int userId) async {
    final response = await _dio.get<Object?>('/users/$userId/followers');
    return FollowerListType.fromJson(asJsonMap(response.data));
  }

  /// web 은 앞 슬래시 없이 `users/...` 로 부른다. 같은 경로다 (PLAN §3).
  Future<FollowingListType> getFollowingList(int userId) async {
    final response = await _dio.get<Object?>('/users/$userId/followings');
    return FollowingListType.fromJson(asJsonMap(response.data));
  }

  /// backend `UserController.follow` (204).
  Future<void> follow(int userId) => _dio.post<void>('/follow/$userId');

  /// backend `UserController.unfollow` (204).
  Future<void> unfollow(int userId) => _dio.delete<void>('/follow/$userId');

  /// 내 팔로워에서 [userId] 를 뺀다. backend `UserController.deleteFollower` (204).
  Future<void> deleteFollower(int userId) =>
      _dio.delete<void>('/followers/$userId');
}

final followApiProvider = Provider<FollowApi>(
  (ref) => FollowApi(ref.watch(dioProvider)),
);
