import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/history_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/history/*.ts`.
class HistoryApi {
  const HistoryApi(this._dio);

  final Dio _dio;

  Future<List<HistoryType>> getHistories(int listId) async {
    final response = await _dio.get<Object?>('/lists/$listId/histories');
    return asJsonList(response.data, HistoryType.fromJson);
  }

  /// 공개/비공개 토글. body 없음 (`HistoryController.updatePublic`, 204).
  Future<void> togglePublic(int historyId) =>
      _dio.patch<void>('/histories/$historyId');

  Future<void> delete(int historyId) =>
      _dio.delete<void>('/histories/$historyId');
}

final historyApiProvider = Provider<HistoryApi>(
  (ref) => HistoryApi(ref.watch(dioProvider)),
);
