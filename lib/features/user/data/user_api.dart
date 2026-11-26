import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/list_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// `GET /users/{userId}/lists?type=` 값.
enum UserListType { my, collabo }

/// web `_api/user/getUserOne.ts`, `_api/list/getAllList.ts`.
class UserApi {
  const UserApi(this._dio);

  final Dio _dio;

  static const listPageSize = 10;

  Future<UserType> getUserOne(int userId) async {
    final response = await _dio.get<Object?>('/users/$userId');
    return UserType.fromJson(asJsonMap(response.data));
  }

  Future<AllListType> getAllList(
    int userId, {
    required UserListType type,
    required String category,
    String? cursorUpdatedDate,
  }) async {
    final response = await _dio.get<Object?>(
      '/users/$userId/lists',
      queryParameters: {
        'type': type.name,
        'category': category,
        'size': listPageSize,
        'cursorUpdatedDate': ?cursorUpdatedDate,
      },
    );
    return AllListType.fromJson(asJsonMap(response.data));
  }
}

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(ref.watch(dioProvider)),
);
