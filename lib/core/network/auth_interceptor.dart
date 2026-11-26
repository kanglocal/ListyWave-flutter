import 'package:dio/dio.dart';

import '../auth/token_storage.dart';

/// `RequestOptions.extra` 키.
abstract final class AuthExtra {
  /// true 면 `Authorization` 을 붙이지 않는다 (공개 GET fallback 재시도).
  static const skipAuth = 'auth.skip';

  /// true 면 401 이어도 refresh 하지 않는다 (재시도한 요청, 로그아웃 요청).
  static const skipRefresh = 'auth.skipRefresh';
}

const refreshTokenPath = '/auth/token';

/// interceptor 순서 1번 (PLAN §4.3). AT 가 있으면 `Authorization: Bearer` 를 붙인다.
/// `/auth/token` 에는 RT 를 붙인다.
class AuthInterceptor extends QueuedInterceptorsWrapper {
  AuthInterceptor(this._storage);

  final TokenStorage _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[AuthExtra.skipAuth] == true) {
      options.headers.remove('Authorization');
      return handler.next(options);
    }
    final token = options.path == refreshTokenPath
        ? await _storage.readRefreshToken()
        : await _storage.readAccessToken();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
