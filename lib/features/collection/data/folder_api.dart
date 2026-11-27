import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/folder_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/folder/*.ts`, `_api/collect/getCollection.ts`.
class FolderApi {
  const FolderApi(this._dio);

  final Dio _dio;

  Future<List<FoldersType>> getFolders() async {
    final response = await _dio.get<Object?>('/folders');
    return FoldersResponseType.fromJson(asJsonMap(response.data)).folders;
  }

  /// backend `FolderCreateRequest{folderName}` → `FolderCreateResponse{folderId}` (201).
  Future<int> createFolder(String folderName) async {
    final response = await _dio.post<Object?>(
      '/folders',
      data: {'folderName': folderName},
    );
    return asJsonMap(response.data)['folderId'] as int;
  }

  /// backend `FolderUpdateRequest{folderName}` (204).
  Future<void> updateFolder(int folderId, String folderName) =>
      _dio.put<void>('/folders/$folderId', data: {'folderName': folderName});

  /// 폴더와 그 안의 콜렉트를 지운다 (204).
  Future<void> deleteFolder(int folderId) =>
      _dio.delete<void>('/folders/$folderId');

  /// 폴더 한 페이지 크기 (web `size=10`).
  static const collectionPageSize = 10;

  /// [folderId] 가 0 이면 모든 폴더의 콜렉트다 (backend `CollectionService.getCollection`).
  Future<CollectionListResponseType> getCollection(
    int folderId, {
    int? cursorId,
  }) async {
    final response = await _dio.get<Object?>(
      '/folder/$folderId/collections',
      queryParameters: {'size': collectionPageSize, 'cursorId': ?cursorId},
    );
    return CollectionListResponseType.fromJson(asJsonMap(response.data));
  }
}

final folderApiProvider = Provider<FolderApi>(
  (ref) => FolderApi(ref.watch(dioProvider)),
);
