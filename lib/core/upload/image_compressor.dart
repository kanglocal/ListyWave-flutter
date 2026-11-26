import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 압축에 필요한 이미지 연산. 테스트는 가짜 구현을 넣는다.
abstract interface class ImageCodec {
  /// 원본 가로/세로 px.
  Future<({int width, int height})> sizeOf(Uint8List bytes);

  /// [width] x [height] 로 줄여 JPEG [quality] 로 다시 인코딩한다.
  Future<Uint8List> encodeJpeg(
    Uint8List bytes, {
    required int width,
    required int height,
    required int quality,
  });
}

/// `flutter_image_compress` (네이티브 인코더) 구현.
class NativeImageCodec implements ImageCodec {
  const NativeImageCodec();

  @override
  Future<({int width, int height})> sizeOf(Uint8List bytes) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final size = (width: descriptor.width, height: descriptor.height);
    descriptor.dispose();
    buffer.dispose();
    return size;
  }

  /// plugin 은 비율을 지키며 `minWidth x minHeight` 보다 작아지지 않을 만큼만 줄인다.
  /// 목표 크기를 그대로 넘기면 정확히 그 크기가 된다.
  @override
  Future<Uint8List> encodeJpeg(
    Uint8List bytes, {
    required int width,
    required int height,
    required int quality,
  }) => FlutterImageCompress.compressWithList(
    bytes,
    minWidth: width,
    minHeight: height,
    quality: quality,
  );
}

/// web `compressFile.ts` (4MB, 1920px). web 은 `file.size <= 4` 로 byte 를 비교해
/// 사실상 항상 압축하지만, 앱은 4MB 를 넘을 때만 압축한다 (PLAN §6).
class ImageCompressor {
  const ImageCompressor(this._codec);

  static const maxBytes = 4 * 1024 * 1024;
  static const maxLongSide = 1920;
  static const _startQuality = 90;
  static const _qualityStep = 10;
  static const _minQuality = 10;

  final ImageCodec _codec;

  /// 4MB 이하면 그대로 돌려준다. 넘으면 긴 변을 1920px 이하로 줄이고
  /// 4MB 이하가 될 때까지 quality 를 낮춘다. 가장 낮은 quality 로도 넘으면 크기를 더 줄인다.
  Future<({Uint8List bytes, String mimeType})> compress(
    Uint8List bytes, {
    required String mimeType,
  }) async {
    if (bytes.length <= maxBytes) return (bytes: bytes, mimeType: mimeType);

    final size = await _codec.sizeOf(bytes);
    var scale = math.min(1.0, maxLongSide / math.max(size.width, size.height));
    while (true) {
      final width = math.max(1, (size.width * scale).round());
      final height = math.max(1, (size.height * scale).round());
      for (
        var quality = _startQuality;
        quality >= _minQuality;
        quality -= _qualityStep
      ) {
        final out = await _codec.encodeJpeg(
          bytes,
          width: width,
          height: height,
          quality: quality,
        );
        if (out.length <= maxBytes) return (bytes: out, mimeType: 'image/jpeg');
      }
      scale *= 0.75;
    }
  }
}

final imageCompressorProvider = Provider<ImageCompressor>(
  (ref) => const ImageCompressor(NativeImageCodec()),
);
