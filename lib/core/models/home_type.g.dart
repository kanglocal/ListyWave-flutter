// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Top3Type _$Top3TypeFromJson(Map<String, dynamic> json) => _Top3Type(
  id: (json['id'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  title: json['title'] as String,
);

Map<String, dynamic> _$Top3TypeToJson(_Top3Type instance) => <String, dynamic>{
  'id': instance.id,
  'rank': instance.rank,
  'title': instance.title,
};

_HomeRecommendedListType _$HomeRecommendedListTypeFromJson(
  Map<String, dynamic> json,
) => _HomeRecommendedListType(
  id: (json['id'] as num).toInt(),
  ownerId: (json['ownerId'] as num).toInt(),
  ownerNickname: json['ownerNickname'] as String,
  title: json['title'] as String,
  itemImageUrl: json['itemImageUrl'] as String?,
  category: json['category'] as String,
  backgroundColor: json['backgroundColor'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => Top3Type.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HomeRecommendedListTypeToJson(
  _HomeRecommendedListType instance,
) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'ownerNickname': instance.ownerNickname,
  'title': instance.title,
  'itemImageUrl': instance.itemImageUrl,
  'category': instance.category,
  'backgroundColor': instance.backgroundColor,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

_UsersRecommendationItemType _$UsersRecommendationItemTypeFromJson(
  Map<String, dynamic> json,
) => _UsersRecommendationItemType(
  id: (json['id'] as num).toInt(),
  nickname: json['nickname'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UsersRecommendationItemTypeToJson(
  _UsersRecommendationItemType instance,
) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};

_HomeListItemType _$HomeListItemTypeFromJson(Map<String, dynamic> json) =>
    _HomeListItemType(
      id: (json['id'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$HomeListItemTypeToJson(_HomeListItemType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'title': instance.title,
    };

_ListRecommendationType _$ListRecommendationTypeFromJson(
  Map<String, dynamic> json,
) => _ListRecommendationType(
  id: (json['id'] as num).toInt(),
  ownerId: (json['ownerId'] as num).toInt(),
  ownerNickname: json['ownerNickname'] as String,
  ownerProfileImage: json['ownerProfileImage'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  items: (json['items'] as List<dynamic>)
      .map((e) => HomeListItemType.fromJson(e as Map<String, dynamic>))
      .toList(),
  updateCount: (json['updateCount'] as num).toInt(),
);

Map<String, dynamic> _$ListRecommendationTypeToJson(
  _ListRecommendationType instance,
) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'ownerNickname': instance.ownerNickname,
  'ownerProfileImage': instance.ownerProfileImage,
  'title': instance.title,
  'description': instance.description,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'updateCount': instance.updateCount,
};

_FeedListsType _$FeedListsTypeFromJson(Map<String, dynamic> json) =>
    _FeedListsType(
      hasNext: json['hasNext'] as bool,
      cursorUpdatedDate: json['cursorUpdatedDate'] as String?,
      lists: (json['lists'] as List<dynamic>)
          .map(
            (e) => ListRecommendationType.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$FeedListsTypeToJson(_FeedListsType instance) =>
    <String, dynamic>{
      'hasNext': instance.hasNext,
      'cursorUpdatedDate': instance.cursorUpdatedDate,
      'lists': instance.lists.map((e) => e.toJson()).toList(),
    };

_RecommendedTopicType _$RecommendedTopicTypeFromJson(
  Map<String, dynamic> json,
) => _RecommendedTopicType(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  categoryKorName: json['categoryKorName'] as String,
);

Map<String, dynamic> _$RecommendedTopicTypeToJson(
  _RecommendedTopicType instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryKorName': instance.categoryKorName,
};
