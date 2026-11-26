import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/env.dart';
import '../auth/auth_controller.dart';
import '../auth/token_storage.dart';
import 'app_exception.dart';
import 'auth_interceptor.dart';
import 'refresh_interceptor.dart';

BaseOptions _baseOptions(Env env) => BaseOptions(
  baseUrl: env.apiBaseUrl,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 20),
);

/// 토큰 갱신 전용 Dio. interceptor 가 없다 (PLAN §4.3).
final refreshDioProvider = Provider<Dio>((ref) {
  final dio = Dio(_baseOptions(ref.watch(envProvider)));
  ref.onDispose(dio.close);
  return dio;
});

/// 백엔드 API 용 Dio. interceptor 순서는 PLAN §4.3 과 같다.
final dioProvider = Provider<Dio>((ref) {
  final env = ref.watch(envProvider);
  final storage = ref.watch(tokenStorageProvider);
  final dio = Dio(_baseOptions(env));
  dio.interceptors.addAll([
    AuthInterceptor(storage),
    RefreshInterceptor(
      dio: dio,
      refreshDio: ref.watch(refreshDioProvider),
      storage: storage,
      onSessionExpired: () => ref
          .read(authControllerProvider.notifier)
          .logout(LogoutReason.expired),
    ),
    const ErrorMapper(),
    if (env.isDev)
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (line) => debugPrint('$line'),
      ),
  ]);
  ref.onDispose(dio.close);
  return dio;
});
