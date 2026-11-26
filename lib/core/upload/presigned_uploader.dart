import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';

/// R2 presigned URL 로 파일을 PUT 한다 (web `uploadItemImages.ts`).
///
/// 백엔드용 Dio 와 따로 둔다: baseUrl 이 없고, `Authorization` 을 붙이는 interceptor 도 없다.
/// presigned URL 은 서명에 Content-Type 이 들어가므로 파일 MIME 을 그대로 보낸다.
class PresignedUploader {
  PresignedUploader(this.dio);

  final Dio dio;

  Future<void> put(
    String presignedUrl,
    Uint8List bytes, {
    required String contentType,
  }) async {
    await dio.put<void>(
      presignedUrl,
      data: bytes,
      options: Options(contentType: contentType),
    );
  }
}

/// 파일 이름과 앞부분 byte 로 MIME 을 고른다. 모르면 `application/octet-stream` 이다.
String mimeTypeOf(String fileName, Uint8List bytes) =>
    lookupMimeType(
      fileName,
      headerBytes: bytes.length > defaultMagicNumbersMaxLength
          ? bytes.sublist(0, defaultMagicNumbersMaxLength)
          : bytes,
    ) ??
    'application/octet-stream';

final presignedUploaderProvider = Provider<PresignedUploader>((ref) {
  final dio = Dio();
  ref.onDispose(dio.close);
  return PresignedUploader(dio);
});
