import 'dart:async';

import 'package:dio/dio.dart';

import '../auth/token_storage.dart';
import 'auth_interceptor.dart';

/// interceptor 순서 2번 (PLAN §4.3). 401 이면 AT 를 한 번만 갱신하고 원 요청을 1회 재시도한다.
///
/// web `axiosInstance.ts` 와 다른 점:
/// - body 없는 401 (`MalformedJwtException`) 도 갱신 대상이다.
/// - 동시에 온 401 은 진행 중인 갱신 하나를 같이 기다린다 (web 은 그냥 reject).
/// - 갱신할 수 없거나 실패하면, GET 은 `Authorization` 없이 한 번 더 보낸다.
///   만료 토큰 때문에 공개 API 열람이 막히지 않게 하기 위해서다 (`AuthorizationInterceptor.java`).
class RefreshInterceptor extends Interceptor {
  RefreshInterceptor({
    required Dio dio,
    required Dio refreshDio,
    required TokenStorage storage,
    required Future<void> Function() onSessionExpired,
  }) : _dio = dio,
       _refreshDio = refreshDio,
       _storage = storage,
       _onSessionExpired = onSessionExpired;

  final Dio _dio;

  /// interceptor 가 없는 Dio. 갱신 요청이 이 interceptor 를 다시 타지 않게 한다.
  final Dio _refreshDio;
  final TokenStorage _storage;
  final Future<void> Function() _onSessionExpired;

  Completer<String?>? _refreshing;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    final sentToken = _bearerOf(request);
    if (err.response?.statusCode != 401 ||
        request.path == refreshTokenPath ||
        request.extra[AuthExtra.skipRefresh] == true ||
        sentToken == null) {
      return handler.next(err);
    }

    // 다른 요청이 이미 갱신을 끝냈으면 새 AT 로 바로 재시도한다.
    final current = await _storage.readAccessToken();
    final token = current != null && current != sentToken
        ? current
        : await _refresh();

    if (token != null) {
      return _retry(request, handler, {
        AuthExtra.skipRefresh: true,
      }, token: token);
    }
    if (request.method == 'GET') {
      return _retry(request, handler, {
        AuthExtra.skipRefresh: true,
        AuthExtra.skipAuth: true,
      });
    }
    handler.next(err);
  }

  /// 진행 중인 갱신이 있으면 그것을 기다린다. 새 AT 를, 갱신할 수 없으면 null 을 준다.
  Future<String?> _refresh() {
    final running = _refreshing;
    if (running != null) return running.future;

    final completer = _refreshing = Completer<String?>();
    () async {
      String? token;
      try {
        final refreshToken = await _storage.readRefreshToken();
        if (refreshToken != null) {
          final response = await _refreshDio.get<Map<String, dynamic>>(
            refreshTokenPath,
            options: Options(
              headers: {'Authorization': 'Bearer $refreshToken'},
            ),
          );
          final accessToken = response.data?['accessToken'];
          if (accessToken is String && accessToken.isNotEmpty) {
            await _storage.saveAccessToken(accessToken);
            token = accessToken;
          }
        }
      } on DioException {
        token = null;
      }
      // 로그아웃이 실패해도 기다리는 요청들이 멈추지 않게 completer 는 반드시 끝낸다.
      try {
        if (token == null) await _onSessionExpired();
      } finally {
        _refreshing = null;
        completer.complete(token);
      }
    }();
    return completer.future;
  }

  Future<void> _retry(
    RequestOptions request,
    ErrorInterceptorHandler handler,
    Map<String, Object> extra, {
    String? token,
  }) async {
    final headers = Map<String, dynamic>.of(request.headers)
      ..remove('Authorization');
    if (token != null) headers['Authorization'] = 'Bearer $token';
    try {
      final response = await _dio.fetch<dynamic>(
        request.copyWith(headers: headers, extra: {...request.extra, ...extra}),
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  static String? _bearerOf(RequestOptions request) {
    final value = request.headers['Authorization'];
    if (value is! String || !value.startsWith('Bearer ')) return null;
    return value.substring('Bearer '.length);
  }
}
