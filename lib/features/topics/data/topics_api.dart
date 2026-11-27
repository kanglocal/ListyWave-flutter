import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/requested_topic_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/topics/getTopics.ts`, `createTopic.ts`.
class TopicsApi {
  const TopicsApi(this._dio);

  final Dio _dio;

  /// 한 페이지 크기 (web `size=10`).
  static const pageSize = 10;

  Future<TopicsResponseType> getTopics({int? cursorId}) async {
    final response = await _dio.get<Object?>(
      '/topics',
      queryParameters: {'size': pageSize, 'cursorId': ?cursorId},
    );
    return TopicsResponseType.fromJson(asJsonMap(response.data));
  }

  /// backend `TopicCreateRequest{categoryKorName, title, description, isAnonymous}` (204).
  /// 관리자가 검토한 뒤 노출한다.
  Future<void> createTopic({
    required String categoryKorName,
    required String title,
    required String description,
    required bool isAnonymous,
  }) => _dio.post<void>(
    '/topics',
    data: {
      'categoryKorName': categoryKorName,
      'title': title,
      'description': description,
      'isAnonymous': isAnonymous,
    },
  );
}

final topicsApiProvider = Provider<TopicsApi>(
  (ref) => TopicsApi(ref.watch(dioProvider)),
);
