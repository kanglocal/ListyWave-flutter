import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// 아이템 이미지 한 개의 rank 와 확장자. backend `ListImagesCreateRequest.ExtensionRanks`
/// (web `ItemImageType`).
typedef ExtensionRank = ({int rank, String extension});

/// backend `ListItemPresignedUrlResponse` (web `PresignedUrlType`).
typedef ItemPresignedUrl = ({int rank, String presignedUrl});

/// web `_api/list/createList.ts`, `updateList.ts`, `uploadItemImages.ts`.
class ListEditorApi {
  const ListEditorApi(this._dio);

  final Dio _dio;

  /// backend `ListCreateRequest` → `ListCreateResponse{listId}`.
  Future<int> createList(Map<String, Object?> body) async {
    final response = await _dio.post<Object?>('/lists', data: body);
    return asJsonMap(response.data)['listId'] as int;
  }

  /// backend `ListUpdateRequest` (204).
  Future<void> updateList(int listId, Map<String, Object?> body) =>
      _dio.patch<void>('/lists/$listId', data: body);

  /// rank 별 presigned PUT URL 을 받는다. 서버는 이때 아이템에 새 image key 를 붙인다.
  Future<List<ItemPresignedUrl>> createItemUploadUrls(
    int listId,
    List<ExtensionRank> extensionRanks,
  ) async {
    final response = await _dio.post<Object?>(
      '/lists/upload-url',
      data: _imagesRequest(listId, extensionRanks),
    );
    return [
      for (final e in response.data! as List<dynamic>)
        (
          rank: (e as Map<String, dynamic>)['rank'] as int,
          presignedUrl: e['presignedUrl'] as String,
        ),
    ];
  }

  /// 업로드한 이미지 URL 을 아이템에 저장한다 (204).
  Future<void> completeItemUpload(
    int listId,
    List<ExtensionRank> extensionRanks,
  ) => _dio.post<void>(
    '/lists/upload-complete',
    data: _imagesRequest(listId, extensionRanks),
  );

  /// backend `ListImagesCreateRequest{listId, extensionRanks}`.
  Map<String, Object> _imagesRequest(
    int listId,
    List<ExtensionRank> extensionRanks,
  ) => {
    'listId': listId,
    'extensionRanks': [
      for (final e in extensionRanks)
        {'rank': e.rank, 'extension': e.extension},
    ],
  };
}

final listEditorApiProvider = Provider<ListEditorApi>(
  (ref) => ListEditorApi(ref.watch(dioProvider)),
);
