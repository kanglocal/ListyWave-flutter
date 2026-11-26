import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/folder_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// web `_api/folder/getFolders.ts`, `createFolder.ts`.
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
}

final folderApiProvider = Provider<FolderApi>(
  (ref) => FolderApi(ref.watch(dioProvider)),
);
