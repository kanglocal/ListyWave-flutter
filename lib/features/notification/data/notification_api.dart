import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/notification_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/notification/*.ts`.
class NotificationApi {
  const NotificationApi(this._dio);

  final Dio _dio;

  Future<List<NotificationType>> getNotifications() async {
    final response = await _dio.get<Object?>('/alarms');
    return asJsonList(response.data, NotificationType.fromJson);
  }

  Future<AlarmCheckType> checkNew() async {
    final response = await _dio.get<Object?>('/alarms/check-new');
    return AlarmCheckType.fromJson(asJsonMap(response.data));
  }

  /// 단건 읽음 (204).
  Future<void> read(int alarmId) => _dio.patch<void>('/alarms/$alarmId');

  /// 전체 읽음 (204).
  Future<void> readAll() => _dio.patch<void>('/alarms');
}

final notificationApiProvider = Provider<NotificationApi>(
  (ref) => NotificationApi(ref.watch(dioProvider)),
);
