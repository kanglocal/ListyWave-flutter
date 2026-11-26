import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder_type.freezed.dart';
part 'folder_type.g.dart';

/// web `src/lib/types/folderType.ts` · backend `FolderResponse`.
@freezed
abstract class FoldersType with _$FoldersType {
  const factory FoldersType({
    required int folderId,
    required String folderName,
    required int listCount,
  }) = _FoldersType;

  factory FoldersType.fromJson(Map<String, dynamic> json) =>
      _$FoldersTypeFromJson(json);
}

/// web `_api/folder/getFolders.ts` `FoldersResponseType` · backend `FindFolderResponse`.
@freezed
abstract class FoldersResponseType with _$FoldersResponseType {
  const factory FoldersResponseType({required List<FoldersType> folders}) =
      _FoldersResponseType;

  factory FoldersResponseType.fromJson(Map<String, dynamic> json) =>
      _$FoldersResponseTypeFromJson(json);
}
