import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/core/network/dio_provider.dart';
import 'package:listywave_app/core/upload/presigned_uploader.dart';

import '../../helpers/test_container.dart';

void main() {
  const url =
      'https://bucket.r2.cloudflarestorage.com/lists/7/item-1.jpg?X-Amz-Signature=abc';

  test(
    'presigned PUT 은 Authorization 없이 파일 MIME 을 Content-Type 으로 보낸다',
    () async {
      // 로그인 상태여도 uploader 는 토큰을 붙이지 않아야 한다.
      final container = createTestContainer(
        secure: {'accessToken': 'at', 'refreshToken': 'rt'},
      );
      addTearDown(container.dispose);
      final uploader = container.read(presignedUploaderProvider);
      final sent = <RequestOptions>[];
      DioAdapter(
        dio: uploader.dio,
      ).onPut(url, (s) => s.reply(200, null), data: Matchers.any);
      uploader.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            sent.add(options);
            handler.next(options);
          },
        ),
      );
      final bytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0, 1, 2, 3]);

      await uploader.put(url, bytes, contentType: 'image/jpeg');

      expect(sent, hasLength(1));
      final request = sent.single;
      expect(request.method, 'PUT');
      expect(request.uri.toString(), url);
      expect(request.headers.containsKey('Authorization'), isFalse);
      expect(request.contentType, 'image/jpeg');
      expect(request.headers[Headers.contentTypeHeader], 'image/jpeg');
      expect(request.data, bytes);
      // 백엔드 Dio 와 다른 인스턴스이고 baseUrl 이 없다.
      expect(identical(uploader.dio, container.read(dioProvider)), isFalse);
      expect(uploader.dio.options.baseUrl, isEmpty);
      expect(uploader.dio.interceptors.whereType<QueuedInterceptor>(), isEmpty);
    },
  );

  test('mimeTypeOf 는 확장자와 파일 앞부분으로 MIME 을 고른다', () {
    final jpeg = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0, 0, 0]);
    final png = Uint8List.fromList([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
      0, 0, 0, 0,
    ]);

    expect(mimeTypeOf('photo.png', png), 'image/png');
    expect(mimeTypeOf('photo.jpg', jpeg), 'image/jpeg');
    expect(mimeTypeOf('image_picker_123', png), 'image/png');
    expect(mimeTypeOf('blob', Uint8List(4)), 'application/octet-stream');
  });
}
