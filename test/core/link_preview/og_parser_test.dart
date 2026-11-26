import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/link_preview/link_preview_fetcher.dart';
import 'package:listywave_app/core/link_preview/og_parser.dart';

/// 응답을 [chunks] 로 나눠 흘려보내는 adapter. 요청 주소와 취소 여부를 기록한다.
class _ChunkedAdapter implements HttpClientAdapter {
  _ChunkedAdapter(
    this.chunks, {
    this.contentType = 'text/html; charset=utf-8',
    this.delay = Duration.zero,
  });

  final List<List<int>> chunks;
  final String contentType;
  final Duration delay;
  bool cancelled = false;
  final requested = <Uri>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requested.add(options.uri);
    unawaited(cancelFuture?.then((_) => cancelled = true));
    if (delay > Duration.zero) await Future<void>.delayed(delay);
    Stream<Uint8List> body() async* {
      for (final chunk in chunks) {
        yield Uint8List.fromList(chunk);
      }
    }

    return ResponseBody(
      body(),
      200,
      headers: {
        Headers.contentTypeHeader: [contentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

LinkPreviewFetcher _fetcher(
  _ChunkedAdapter adapter, {
  Duration timeout = LinkPreviewFetcher.defaultTimeout,
  int maxBytes = LinkPreviewFetcher.defaultMaxBytes,
}) => LinkPreviewFetcher(
  Dio()..httpClientAdapter = adapter,
  timeout: timeout,
  maxBytes: maxBytes,
);

const _page = '''
<!doctype html>
<html><head>
  <title>문서 제목</title>
  <meta property="og:title" content="테일러커피 후기">
  <meta property="og:description" content="성수 라떼 맛집">
  <meta property="og:image" content="/images/cover.jpg">
  <meta property="og:image" content="/images/second.jpg">
  <meta property="og:url" content="https://blog.example.com/taylor">
  <meta name="description" content="og 가 아닌 설명">
</head><body>본문</body></html>
''';

void main() {
  group('parseOgData', () {
    test('og:title / og:description / og:image / og:url 을 읽는다', () {
      final og = parseOgData(
        _page,
        pageUrl: Uri.parse('https://blog.example.com/posts/1'),
      );

      expect(og.title, '테일러커피 후기');
      expect(og.description, '성수 라떼 맛집');
      // 상대 경로는 페이지 주소 기준으로 바꾸고, 여러 개면 첫 값을 쓴다.
      expect(og.image, 'https://blog.example.com/images/cover.jpg');
      expect(og.url, 'https://blog.example.com/taylor');
      expect(og.hasContent, isTrue);
    });

    test('og 태그가 없으면 비어 있다 (title/name=description 은 쓰지 않는다)', () {
      final og = parseOgData(
        '<html><head><title>t</title>'
        '<meta name="description" content="d"></head></html>',
      );

      expect(og, const OgData());
      expect(og.hasContent, isFalse);
    });
  });

  group('LinkPreviewFetcher', () {
    test('HTML 을 받아 og 값을 돌려준다', () async {
      final adapter = _ChunkedAdapter([utf8.encode(_page)]);

      final og = await _fetcher(
        adapter,
      ).fetch('https://blog.example.com/posts/1');

      expect(og.title, '테일러커피 후기');
      expect(og.image, 'https://blog.example.com/images/cover.jpg');
      expect(
        adapter.requested.single.toString(),
        'https://blog.example.com/posts/1',
      );
    });

    test('응답이 maxBytes 를 넘으면 그 앞까지만 읽고 나머지 전송을 멈춘다', () async {
      // 앞부분에 og:title, maxBytes 뒤에 og:description 이 있다.
      final head = utf8.encode(
        '<html><head><meta property="og:title" content="앞쪽 제목">',
      );
      final filler = List<int>.filled(1024, 0x20);
      final tail = utf8.encode(
        '<meta property="og:description" content="뒤쪽 설명"></head></html>',
      );
      final chunks = [head, for (var i = 0; i < 64; i++) filler, tail];
      final adapter = _ChunkedAdapter(chunks);

      final og = await _fetcher(
        adapter,
        maxBytes: 8 * 1024,
      ).fetch('https://big.example.com');

      // maxBytes 뒤에 있는 태그는 읽지 않는다.
      expect(og.title, '앞쪽 제목');
      expect(og.description, isNull);
      // 다 읽으면 남은 전송을 끊도록 요청을 취소한다.
      await pumpEventQueue();
      expect(adapter.cancelled, isTrue);
    });

    test('기본 한도는 1MB, 기본 timeout 은 5초다 (PLAN §3)', () {
      expect(LinkPreviewFetcher.defaultMaxBytes, 1024 * 1024);
      expect(LinkPreviewFetcher.defaultTimeout, const Duration(seconds: 5));
    });

    test('timeout 안에 응답이 없으면 TimeoutException 을 던지고 요청을 취소한다', () async {
      final adapter = _ChunkedAdapter([
        utf8.encode(_page),
      ], delay: const Duration(milliseconds: 300));

      await expectLater(
        _fetcher(
          adapter,
          timeout: const Duration(milliseconds: 50),
        ).fetch('https://slow.example.com'),
        throwsA(isA<TimeoutException>()),
      );
      await pumpEventQueue();
      expect(adapter.cancelled, isTrue);
    });

    test('HTML 이 아니면 빈 값을 돌려주고 전송을 끊는다', () async {
      final adapter = _ChunkedAdapter([
        utf8.encode('{}'),
      ], contentType: 'application/json');

      final og = await _fetcher(adapter).fetch('https://api.example.com/x');

      expect(og, const OgData());
      await pumpEventQueue();
      expect(adapter.cancelled, isTrue);
    });

    test('http/https 가 아닌 주소는 요청하지 않는다', () async {
      final adapter = _ChunkedAdapter([utf8.encode(_page)]);
      final fetcher = _fetcher(adapter);

      expect(await fetcher.fetch('ftp://example.com/a'), const OgData());
      expect(await fetcher.fetch('javascript:alert(1)'), const OgData());
      expect(await fetcher.fetch('not a url'), const OgData());
      expect(adapter.requested, isEmpty);
    });
  });
}
