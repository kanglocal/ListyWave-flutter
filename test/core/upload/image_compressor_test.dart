import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/upload/image_compressor.dart';
import 'package:mocktail/mocktail.dart';

class _MockCodec extends Mock implements ImageCodec {}

/// 결과 크기가 `width * height * quality / divisor` byte 인 가짜 인코더.
void _stubEncoder(_MockCodec codec, {required int divisor}) {
  when(
    () => codec.encodeJpeg(
      any(),
      width: any(named: 'width'),
      height: any(named: 'height'),
      quality: any(named: 'quality'),
    ),
  ).thenAnswer((call) async {
    final width = call.namedArguments[#width] as int;
    final height = call.namedArguments[#height] as int;
    final quality = call.namedArguments[#quality] as int;
    return Uint8List(width * height * quality ~/ divisor);
  });
}

List<(int, int, int)> _encodeCalls(_MockCodec codec) {
  final captured = verify(
    () => codec.encodeJpeg(
      any(),
      width: captureAny(named: 'width'),
      height: captureAny(named: 'height'),
      quality: captureAny(named: 'quality'),
    ),
  ).captured;
  return [
    for (var i = 0; i < captured.length; i += 3)
      (captured[i] as int, captured[i + 1] as int, captured[i + 2] as int),
  ];
}

void main() {
  const mb = 1024 * 1024;
  late _MockCodec codec;
  late ImageCompressor compressor;

  setUpAll(() => registerFallbackValue(Uint8List(0)));

  setUp(() {
    codec = _MockCodec();
    compressor = ImageCompressor(codec);
  });

  test('4MB 이하 입력은 건드리지 않는다', () async {
    final input = Uint8List(4 * mb);

    final out = await compressor.compress(input, mimeType: 'image/png');

    expect(identical(out.bytes, input), isTrue);
    expect(out.mimeType, 'image/png');
    verifyZeroInteractions(codec);
  });

  test('4MB 를 넘으면 긴 변을 1920 으로 줄이고 4MB 이하가 될 때까지 quality 를 낮춘다', () async {
    final input = Uint8List(6 * mb);
    when(
      () => codec.sizeOf(input),
    ).thenAnswer((_) async => (width: 4000, height: 3000));
    _stubEncoder(codec, divisor: 50);

    final out = await compressor.compress(input, mimeType: 'image/png');

    expect(out.bytes.length, lessThanOrEqualTo(ImageCompressor.maxBytes));
    expect(out.mimeType, 'image/jpeg');
    // 1920x1440 에서 q90 = 4.98MB, q80 = 4.42MB, q70 = 3.87MB
    expect(_encodeCalls(codec), [
      (1920, 1440, 90),
      (1920, 1440, 80),
      (1920, 1440, 70),
    ]);
  });

  test('세로 사진도 긴 변(세로)을 1920 이하로 맞춘다', () async {
    final input = Uint8List(5 * mb);
    when(
      () => codec.sizeOf(input),
    ).thenAnswer((_) async => (width: 3000, height: 5000));
    _stubEncoder(codec, divisor: 100);

    final out = await compressor.compress(input, mimeType: 'image/jpeg');

    expect(out.bytes.length, lessThanOrEqualTo(ImageCompressor.maxBytes));
    expect(_encodeCalls(codec), [(1152, 1920, 90)]);
  });

  test('이미 1920 이하인 큰 파일은 크기는 그대로 두고 quality 만 낮춘다', () async {
    final input = Uint8List(9 * mb);
    when(
      () => codec.sizeOf(input),
    ).thenAnswer((_) async => (width: 1200, height: 800));
    _stubEncoder(codec, divisor: 20);

    final out = await compressor.compress(input, mimeType: 'image/heic');

    expect(out.bytes.length, lessThanOrEqualTo(ImageCompressor.maxBytes));
    expect(_encodeCalls(codec).every((c) => c.$1 == 1200 && c.$2 == 800), true);
  });

  test('가장 낮은 quality 로도 4MB 를 넘으면 크기를 더 줄여 4MB 이하로 만든다', () async {
    final input = Uint8List(30 * mb);
    when(
      () => codec.sizeOf(input),
    ).thenAnswer((_) async => (width: 8000, height: 8000));
    _stubEncoder(codec, divisor: 1);

    final out = await compressor.compress(input, mimeType: 'image/png');

    expect(out.bytes.length, lessThanOrEqualTo(ImageCompressor.maxBytes));
    final calls = _encodeCalls(codec);
    expect(calls.first, (1920, 1920, 90));
    expect(calls.every((c) => c.$1 <= 1920 && c.$2 <= 1920), isTrue);
    expect(calls.last.$1, lessThan(1920));
  });
}
