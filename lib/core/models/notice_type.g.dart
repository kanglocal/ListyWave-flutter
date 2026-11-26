// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeListItemType _$NoticeListItemTypeFromJson(Map<String, dynamic> json) =>
    _NoticeListItemType(
      id: (json['id'] as num).toInt(),
      createdDate: json['createdDate'] as String,
      title: json['title'] as String,
      itemImageUrl: json['itemImageUrl'] as String?,
      category: json['category'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$NoticeListItemTypeToJson(_NoticeListItemType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'title': instance.title,
      'itemImageUrl': instance.itemImageUrl,
      'category': instance.category,
      'description': instance.description,
    };

_NoticeContentType _$NoticeContentTypeFromJson(Map<String, dynamic> json) =>
    _NoticeContentType(
      type: $enumDecode(
        _$NoticeContentsTypeEnumMap,
        json['type'],
        unknownValue: NoticeContentsType.unknown,
      ),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      buttonName: json['buttonName'] as String?,
      buttonLink: json['buttonLink'] as String?,
    );

Map<String, dynamic> _$NoticeContentTypeToJson(_NoticeContentType instance) =>
    <String, dynamic>{
      'type': _$NoticeContentsTypeEnumMap[instance.type]!,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'buttonName': instance.buttonName,
      'buttonLink': instance.buttonLink,
    };

const _$NoticeContentsTypeEnumMap = {
  NoticeContentsType.subtitle: 'subtitle',
  NoticeContentsType.body: 'body',
  NoticeContentsType.image: 'image',
  NoticeContentsType.button: 'button',
  NoticeContentsType.line: 'line',
  NoticeContentsType.note: 'note',
  NoticeContentsType.unknown: 'unknown',
};

_BesideNoticeType _$BesideNoticeTypeFromJson(Map<String, dynamic> json) =>
    _BesideNoticeType(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BesideNoticeTypeToJson(_BesideNoticeType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };

_NoticeDetailType _$NoticeDetailTypeFromJson(
  Map<String, dynamic> json,
) => _NoticeDetailType(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  contents: (json['contents'] as List<dynamic>)
      .map((e) => NoticeContentType.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdDate: json['createdDate'] as String,
  prevNotice: json['prevNotice'] == null
      ? null
      : BesideNoticeType.fromJson(json['prevNotice'] as Map<String, dynamic>),
  nextNotice: json['nextNotice'] == null
      ? null
      : BesideNoticeType.fromJson(json['nextNotice'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NoticeDetailTypeToJson(_NoticeDetailType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
      'createdDate': instance.createdDate,
      'prevNotice': instance.prevNotice?.toJson(),
      'nextNotice': instance.nextNotice?.toJson(),
    };
