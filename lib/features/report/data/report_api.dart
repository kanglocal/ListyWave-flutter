import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// backend `ReportTargetType`.
enum ReportTargetType {
  list('LIST'),
  comment('COMMENT'),
  reply('REPLY');

  const ReportTargetType(this.code);

  final String code;
}

/// backend `ReportReason`. 화면 순서는 web `reportReasons.ts` 와 같다.
enum ReportReason {
  spam('SPAM'),
  abuse('ABUSE'),
  sexual('SEXUAL'),
  illegal('ILLEGAL'),
  privacy('PRIVACY'),
  etc('ETC');

  const ReportReason(this.code);

  final String code;
}

/// web `_api/report/createReport.ts`.
class ReportApi {
  const ReportApi(this._dio);

  final Dio _dio;

  /// backend `ReportRequest{targetType, targetId, reason, detail}` (201 `{reportId}`).
  /// [detail] 이 null 이면 보내지 않는다.
  Future<int> create({
    required ReportTargetType targetType,
    required int targetId,
    required ReportReason reason,
    String? detail,
  }) async {
    final response = await _dio.post<Object?>(
      '/reports',
      data: {
        'targetType': targetType.code,
        'targetId': targetId,
        'reason': reason.code,
        'detail': ?detail,
      },
    );
    return asJsonMap(response.data)['reportId'] as int;
  }
}

final reportApiProvider = Provider<ReportApi>(
  (ref) => ReportApi(ref.watch(dioProvider)),
);
