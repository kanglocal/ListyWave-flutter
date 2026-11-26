import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/home_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `src/app/_api/home/*`.
class HomeApi {
  const HomeApi(this._dio);

  final Dio _dio;

  /// 피드 한 페이지 크기 (web `size: '10'`).
  static const pageSize = 10;

  /// `getHomeRecommendedLists.ts`.
  Future<List<HomeRecommendedListType>> getHomeRecommendedLists() async {
    final response = await _dio.get<Object?>('/lists/recommend');
    return asJsonList(response.data, HomeRecommendedListType.fromJson);
  }

  /// `getRecentLists.ts`. web 과 같이 category 를 늘 보낸다 (기본 `entire`).
  Future<FeedListsType> getRecentLists({
    String? cursorUpdatedDate,
    required String category,
  }) async {
    final response = await _dio.get<Object?>(
      '/lists',
      queryParameters: {
        'size': pageSize,
        'cursorUpdatedDate': ?cursorUpdatedDate,
        'category': category,
      },
    );
    return FeedListsType.fromJson(asJsonMap(response.data));
  }

  /// `getFollowingLists.ts`.
  Future<FeedListsType> getFollowingLists({String? cursorUpdatedDate}) async {
    final response = await _dio.get<Object?>(
      '/lists/following',
      queryParameters: {
        'size': pageSize,
        'cursorUpdatedDate': ?cursorUpdatedDate,
      },
    );
    return FeedListsType.fromJson(asJsonMap(response.data));
  }

  /// `getRecommendedUsers.ts`.
  Future<List<UserProfileType>> getRecommendedUsers() async {
    final response = await _dio.get<Object?>('/users/recommend');
    return asJsonList(response.data, UserProfileType.fromJson);
  }

  /// `getRecommendedTopics.ts`.
  Future<List<RecommendedTopicType>> getRecommendedTopics() async {
    final response = await _dio.get<Object?>('/topics/recommend');
    return asJsonList(response.data, RecommendedTopicType.fromJson);
  }
}

final homeApiProvider = Provider<HomeApi>(
  (ref) => HomeApi(ref.watch(dioProvider)),
);
