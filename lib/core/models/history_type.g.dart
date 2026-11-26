// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryItemType _$HistoryItemTypeFromJson(Map<String, dynamic> json) =>
    _HistoryItemType(
      id: (json['id'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$HistoryItemTypeToJson(_HistoryItemType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'title': instance.title,
    };

_HistoryType _$HistoryTypeFromJson(Map<String, dynamic> json) => _HistoryType(
  id: (json['id'] as num).toInt(),
  createdDate: json['createdDate'] as String,
  isPublic: json['isPublic'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => HistoryItemType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HistoryTypeToJson(_HistoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'isPublic': instance.isPublic,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
