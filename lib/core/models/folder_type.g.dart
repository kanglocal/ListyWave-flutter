// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FoldersType _$FoldersTypeFromJson(Map<String, dynamic> json) => _FoldersType(
  folderId: (json['folderId'] as num).toInt(),
  folderName: json['folderName'] as String,
  listCount: (json['listCount'] as num).toInt(),
);

Map<String, dynamic> _$FoldersTypeToJson(_FoldersType instance) =>
    <String, dynamic>{
      'folderId': instance.folderId,
      'folderName': instance.folderName,
      'listCount': instance.listCount,
    };

_FoldersResponseType _$FoldersResponseTypeFromJson(Map<String, dynamic> json) =>
    _FoldersResponseType(
      folders: (json['folders'] as List<dynamic>)
          .map((e) => FoldersType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoldersResponseTypeToJson(
  _FoldersResponseType instance,
) => <String, dynamic>{
  'folders': instance.folders.map((e) => e.toJson()).toList(),
};
