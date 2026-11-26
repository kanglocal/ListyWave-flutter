import 'package:dio/dio.dart';

/// Riverpod 3 provider 자동 재시도 정책. 기본값은 모든 Exception 을 10번까지 재시도하는데,
/// 그러면 삭제/비공개 리스트(4xx) 같은 확정된 실패도 skeleton 으로 수십 초 기다리게 된다.
/// 응답을 받지 못한 일시적 네트워크 실패만 3번까지 (0.4s, 0.8s, 1.6s) 다시 시도한다.
Duration? appRetry(int retryCount, Object error) {
  if (retryCount >= 3 || error is! DioException) return null;
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError => Duration(
      milliseconds: 400 * (1 << retryCount),
    ),
    _ => null,
  };
}
