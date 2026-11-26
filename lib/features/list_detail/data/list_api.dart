import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/comment_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/list/getListDetail.ts`, `_api/comment/getComments.ts`.
class ListDetailApi {
  const ListDetailApi(this._dio);

  final Dio _dio;

  /// 댓글 한 페이지 크기 (web `size: '24'`).
  static const commentPageSize = 24;

  Future<ListDetailType> getListDetail(int listId) async {
    final response = await _dio.get<Object?>('/lists/$listId');
    return ListDetailType.fromJson(asJsonMap(response.data));
  }

  Future<CommentsResponseType> getComments(int listId, {int? cursorId}) async {
    final response = await _dio.get<Object?>(
      '/lists/$listId/comments',
      queryParameters: {'size': commentPageSize, 'cursorId': ?cursorId},
    );
    return CommentsResponseType.fromJson(asJsonMap(response.data));
  }
}

final listDetailApiProvider = Provider<ListDetailApi>(
  (ref) => ListDetailApi(ref.watch(dioProvider)),
);
