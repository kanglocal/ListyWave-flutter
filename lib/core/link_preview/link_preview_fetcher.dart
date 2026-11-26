import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'og_parser.dart';

/// 기기에서 바로 페이지를 받아 og 태그를 읽는다 (PLAN §3 외부, §6).
/// 네이티브에는 CORS 가 없어 web 의 `/api/getOgDataProxy` 가 필요 없다.
class LinkPreviewFetcher {
  LinkPreviewFetcher(
    this._dio, {
    this.timeout = defaultTimeout,
    this.maxBytes = defaultMaxBytes,
  });

  static const defaultTimeout = Duration(seconds: 5);

  /// og 태그는 `<head>` 에 있으므로 앞부분 1MB 만 읽는다.
  static const defaultMaxBytes = 1024 * 1024;

  final Dio _dio;
  final Duration timeout;
  final int maxBytes;

  /// http/https 가 아니거나, HTML 이 아니거나, 실패하면 빈 [OgData] 다.
  /// [timeout] 이 지나면 [TimeoutException] 을 던진다.
  Future<OgData> fetch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !(uri.scheme == 'http' || uri.scheme == 'https') ||
        uri.host.isEmpty) {
      return const OgData();
    }
    final cancel = CancelToken();
    try {
      return await _fetch(uri, cancel).timeout(timeout);
    } on TimeoutException {
      cancel.cancel('link preview timeout');
      rethrow;
    }
  }

  Future<OgData> _fetch(Uri uri, CancelToken cancel) async {
    final response = await _dio.getUri<ResponseBody>(
      uri,
      cancelToken: cancel,
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Accept': 'text/html'},
        followRedirects: true,
        maxRedirects: 3,
      ),
    );
    final body = response.data;
    if (body == null) return const OgData();
    final contentType = response.headers.value(Headers.contentTypeHeader) ?? '';
    if (!contentType.contains('text/html')) {
      cancel.cancel('not html');
      return const OgData();
    }
    final bytes = <int>[];
    await for (final chunk in body.stream) {
      final room = maxBytes - bytes.length;
      if (chunk.length >= room) {
        bytes.addAll(chunk.take(room));
        break;
      }
      bytes.addAll(chunk);
    }
    // 끝까지 읽지 않았으면 남은 전송을 멈춘다.
    cancel.cancel('read done');
    return parseOgData(
      utf8.decode(bytes, allowMalformed: true),
      pageUrl: response.realUri,
    );
  }
}

/// 링크 미리보기 전용 Dio. backend 인증 interceptor 를 타지 않는다.
final linkPreviewDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: LinkPreviewFetcher.defaultTimeout,
      receiveTimeout: LinkPreviewFetcher.defaultTimeout,
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final linkPreviewFetcherProvider = Provider<LinkPreviewFetcher>(
  (ref) => LinkPreviewFetcher(ref.watch(linkPreviewDioProvider)),
);

/// web `LinkPreview.tsx` 의 useQuery(['linkPreview' + url]).
final linkPreviewProvider = FutureProvider.autoDispose.family<OgData, String>(
  (ref, url) => ref.watch(linkPreviewFetcherProvider).fetch(url),
);
