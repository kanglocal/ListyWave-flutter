import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/env.dart';
import 'package:listywave_app/core/auth/kakao_login_webview.dart';
import 'package:listywave_app/core/link_preview/link_preview_fetcher.dart';
import 'package:listywave_app/core/network/dio_provider.dart';
import 'package:listywave_app/core/network/retry_policy.dart';
import 'package:listywave_app/core/widgets/app_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

const testEnv = Env(
  flavor: Flavor.dev,
  apiBaseUrl: 'http://localhost:8080',
  siteUrl: 'http://localhost:3000',
  imageBaseUrl: 'http://localhost:9000/listywave-local',
  kakaoNativeAppKey: '',
  localLoginId: 'tester',
  localPassword: 'pw',
);

/// platform channel 없이 동작하는 container. [secure] 는 테스트가 그대로 들여다볼 수 있도록
/// 같은 Map 을 storage 로 쓴다 (수정 가능한 Map 이어야 한다).
ProviderContainer createTestContainer({
  Map<String, String>? secure,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
  Future<void> Function()? clearCookies,
}) {
  FlutterSecureStorage.setMockInitialValues(secure ?? {});
  SharedPreferences.setMockInitialValues(prefs);
  return ProviderContainer(
    retry: appRetry,
    overrides: [
      envProvider.overrideWithValue(testEnv),
      clearWebViewCookiesProvider.overrideWithValue(
        clearCookies ?? () async {},
      ),
      // 테스트에는 네트워크와 디스크 캐시(path_provider/sqflite)가 없다.
      networkImageProvider.overrideWithValue(
        (_) => MemoryImage(transparentPng),
      ),
      ...overrides,
    ],
  );
}

/// 백엔드 Dio 와 refresh Dio 에 같은 [DioAdapter] 를 붙이고 보낸 요청을 기록한다.
/// 기록 interceptor 는 맨 뒤에 붙어 실제로 나간 header 를 본다.
class ApiMock {
  ApiMock(ProviderContainer container) {
    final dio = container.read(dioProvider);
    final refreshDio = container.read(refreshDioProvider);
    final linkPreviewDio = container.read(linkPreviewDioProvider);
    // dev flavor 의 LogInterceptor 출력이 테스트 결과를 덮지 않게 뺀다.
    dio.interceptors.removeWhere((i) => i is LogInterceptor);
    adapter = DioAdapter(dio: dio);
    refreshDio.httpClientAdapter = adapter;
    linkPreviewDio.httpClientAdapter = adapter;
    final recorder = InterceptorsWrapper(
      onRequest: (options, handler) {
        requests.add(options);
        handler.next(options);
      },
    );
    dio.interceptors.add(recorder);
    refreshDio.interceptors.add(recorder);
    linkPreviewDio.interceptors.add(recorder);
  }

  late final DioAdapter adapter;
  final List<RequestOptions> requests = [];

  /// method 와 path 가 같은 요청들 (보낸 순서).
  List<RequestOptions> sent(String method, String path) =>
      requests.where((r) => r.method == method && r.uri.path == path).toList();
}

String? authorizationOf(RequestOptions options) =>
    options.headers['Authorization'] as String?;

/// 1x1 투명 PNG.
final transparentPng = Uint8List.fromList(const [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0B,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x60,
  0x00,
  0x02,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x7A,
  0x5E,
  0xAB,
  0x3F,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);
