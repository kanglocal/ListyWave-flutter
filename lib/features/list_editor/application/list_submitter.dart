import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/upload/image_compressor.dart';
import '../../../core/upload/presigned_uploader.dart';
import '../../list_detail/application/list_detail_providers.dart';
import '../../user/application/user_providers.dart';
import '../data/list_editor_api.dart';
import 'list_draft.dart';

/// 리스트는 저장했지만 아이템 이미지 업로드가 실패했다. 화면은 오류를 알리고 [listId] 로 간다
/// (web 은 `uploadImageError` 를 띄우고 상세로 간다).
class ItemImageUploadException implements Exception {
  const ItemImageUploadException(this.listId, this.cause);

  final int listId;
  final Object cause;

  @override
  String toString() => 'ItemImageUploadException($listId, $cause)';
}

/// 리스트 생성/수정과 아이템 이미지 업로드 순서 (PLAN §3 list, §7 M4):
/// `POST /lists` (또는 `PATCH /lists/{id}`) → 새 이미지가 있으면 `POST /lists/upload-url` →
/// presigned `PUT` ×N → `POST /lists/upload-complete`. 새 이미지가 없으면 뒤의 둘을 부르지 않는다.
class ListSubmitter {
  ListSubmitter(this._ref);

  final Ref _ref;

  ListEditorApi get _api => _ref.read(listEditorApiProvider);

  /// 리스트를 만들고 새 listId 를 돌려준다.
  Future<int> create(ListDraft draft) async {
    final images = await _prepareImages(draft);
    final listId = await _api.createList(draft.toJson());
    _ref.invalidate(userListsProvider);
    await _upload(listId, images);
    return listId;
  }

  /// 리스트를 고친다. 기존 이미지는 URL 을 그대로 보내고 새 이미지만 올린다.
  Future<void> update(int listId, ListDraft draft) async {
    final images = await _prepareImages(draft);
    try {
      await _api.updateList(listId, draft.toJson());
      await _upload(listId, images);
    } finally {
      _ref
        ..invalidate(listDetailProvider(listId))
        ..invalidate(userListsProvider);
    }
  }

  /// 업로드 전에 압축하고 backend 가 받는 형식(JPEG/PNG)으로 맞춘다. 저장 요청보다 먼저 해서
  /// 이미지 문제로 리스트만 만들어지는 일을 줄인다.
  Future<List<_UploadImage>> _prepareImages(ListDraft draft) async {
    final compressor = _ref.read(imageCompressorProvider);
    return [
      for (final (:rank, :image) in draft.localImages)
        await compressor
            .prepareForUpload(image.bytes, mimeType: image.mimeType)
            .then(
              (out) => _UploadImage(
                rank: rank,
                bytes: out.bytes,
                mimeType: out.mimeType,
              ),
            ),
    ];
  }

  Future<void> _upload(int listId, List<_UploadImage> images) async {
    if (images.isEmpty) return;
    try {
      final extensionRanks = [
        for (final image in images)
          (rank: image.rank, extension: uploadExtensionOf(image.mimeType)!),
      ];
      final urls = await _api.createItemUploadUrls(listId, extensionRanks);
      final uploader = _ref.read(presignedUploaderProvider);
      for (final url in urls) {
        final image = images.firstWhere((i) => i.rank == url.rank);
        await uploader.put(
          url.presignedUrl,
          image.bytes,
          contentType: image.mimeType,
        );
      }
      await _api.completeItemUpload(listId, extensionRanks);
    } on Exception catch (e) {
      throw ItemImageUploadException(listId, e);
    }
  }
}

class _UploadImage {
  const _UploadImage({
    required this.rank,
    required this.bytes,
    required this.mimeType,
  });

  final int rank;
  final Uint8List bytes;
  final String mimeType;
}

final listSubmitterProvider = Provider<ListSubmitter>(ListSubmitter.new);
