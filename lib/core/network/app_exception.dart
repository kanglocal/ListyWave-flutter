import 'package:dio/dio.dart';

/// 화면이 다루는 API 오류. 백엔드 `ErrorResponse{status, error, code, detail, message}`
/// (`common/exception/ErrorResponse.java`) 에서 화면에 필요한 값만 남긴다.
class AppException implements Exception {
  const AppException({
    required this.status,
    required this.code,
    required this.message,
  });

  /// [DioException] 을 바꾼다. body 가 `ErrorResponse` 가 아니어도 (body 없는 401,
  /// 문자열 500, 네트워크 오류) 값을 채운다.
  factory AppException.fromDioException(DioException e) {
    final error = e.error;
    if (error is AppException) return error;

    final response = e.response;
    final data = response?.data;
    if (data is Map) {
      final status = data['status'];
      final code = data['code'];
      final message = data['message'] ?? data['detail'];
      return AppException(
        status: status is int ? status : response?.statusCode,
        code: code is String ? code : _codeOf(e),
        message: message is String ? message : (e.message ?? ''),
      );
    }
    return AppException(
      status: response?.statusCode,
      code: _codeOf(e),
      message: data is String && data.isNotEmpty ? data : (e.message ?? ''),
    );
  }

  /// catch 한 오류를 [AppException] 으로 맞춘다.
  factory AppException.from(Object error) => switch (error) {
    AppException() => error,
    DioException() => AppException.fromDioException(error),
    _ => AppException(status: null, code: 'UNKNOWN', message: '$error'),
  };

  /// HTTP status. 응답을 받지 못했으면 null 이다.
  final int? status;

  /// 백엔드 `ErrorCode` 이름 (예: `INVALID_ACCESS_TOKEN`). body 가 없으면 아래 값 중 하나다.
  final String code;
  final String message;

  static String _codeOf(DioException e) => switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => 'TIMEOUT',
    DioExceptionType.connectionError => 'NETWORK_ERROR',
    DioExceptionType.cancel => 'CANCELLED',
    _ =>
      e.response == null ? 'NETWORK_ERROR' : 'HTTP_${e.response!.statusCode}',
  };

  @override
  String toString() => 'AppException($status, $code, $message)';
}

/// interceptor 순서 3번 (PLAN §4.3). `DioException.error` 에 [AppException] 을 넣는다.
class ErrorMapper extends Interceptor {
  const ErrorMapper();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is AppException) return handler.next(err);
    handler.next(err.copyWith(error: AppException.fromDioException(err)));
  }
}
