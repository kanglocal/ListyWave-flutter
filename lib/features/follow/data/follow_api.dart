import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/follow_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/follow/getFollowerList.ts`, `getFollowingList.ts`.
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
}

final followApiProvider = Provider<FollowApi>(
  (ref) => FollowApi(ref.watch(dioProvider)),
);
