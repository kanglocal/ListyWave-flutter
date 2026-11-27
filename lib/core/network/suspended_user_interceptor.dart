import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 이용 정지 회원 안내 요청 횟수. 앱 루트(`ListyWaveApp`)가 listen 해서 토스트를 띄운다
/// (BuildContext 없이 dio 에서 알리기 위해서다).
class SuspendedUserNotice extends Notifier<int> {
  @override
  int build() => 0;

  void notify() => state++;
}

final suspendedUserNoticeProvider = NotifierProvider<SuspendedUserNotice, int>(
  SuspendedUserNotice.new,
);

/// web `axiosInstance.ts`: 정지 회원의 요청은 서버가 403 `SUSPENDED_USER` 로 막는다
/// (`AuthorizationInterceptor`, 카카오·local 로그인). 그러면 [onSuspended] 를 부른다.
/// 한 화면에서 여러 요청이 한꺼번에 막혀도 [dedupeWindow] 안에서는 한 번만 부른다.
class SuspendedUserInterceptor extends Interceptor {
  SuspendedUserInterceptor(this.onSuspended, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  static const dedupeWindow = Duration(seconds: 3);

  final void Function() onSuspended;
  final DateTime Function() _clock;
  DateTime? _lastNotifiedAt;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    final data = response?.data;
    if (response?.statusCode == 403 &&
        data is Map &&
        data['code'] == 'SUSPENDED_USER') {
      final now = _clock();
      final last = _lastNotifiedAt;
      if (last == null || now.difference(last) > dedupeWindow) {
        _lastNotifiedAt = now;
        onSuspended();
      }
    }
    handler.next(err);
  }
}
