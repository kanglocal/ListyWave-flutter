import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/notice_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/notice/getNotices.ts`, `getNoticeDetail.ts` (사용자용만).
class NoticeApi {
  const NoticeApi(this._dio);

  final Dio _dio;

  Future<List<NoticeListItemType>> getNotices() async {
    final response = await _dio.get<Object?>('/notices');
    return asJsonList(response.data, NoticeListItemType.fromJson);
  }

  Future<NoticeDetailType> getNoticeDetail(int noticeId) async {
    final response = await _dio.get<Object?>('/notices/$noticeId');
    return NoticeDetailType.fromJson(asJsonMap(response.data));
  }
}

final noticeApiProvider = Provider<NoticeApi>(
  (ref) => NoticeApi(ref.watch(dioProvider)),
);
