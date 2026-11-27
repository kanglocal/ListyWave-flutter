import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'presigned_uploader.dart';

/// 사용자가 고른 이미지 원본 (압축 전).
@immutable
class PickedImage {
  const PickedImage({
    required this.bytes,
    required this.mimeType,
    required this.name,
  });

  final Uint8List bytes;
  final String mimeType;
  final String name;
}

/// 갤러리에서 이미지 한 장을 고른다. 취소하면 null 이다 (web `<input type="file">`).
typedef PickImage = Future<PickedImage?> Function();

/// `image_picker` 구현. 테스트는 platform channel 없이 bytes 를 돌려주는 함수로 바꾼다.
final pickImageProvider = Provider<PickImage>(
  (ref) => () async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return PickedImage(
      bytes: bytes,
      mimeType: file.mimeType ?? mimeTypeOf(file.name, bytes),
      name: file.name,
    );
  },
);
