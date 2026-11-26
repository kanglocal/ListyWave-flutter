// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LabelType _$LabelTypeFromJson(Map<String, dynamic> json) =>
    _LabelType(name: json['name'] as String);

Map<String, dynamic> _$LabelTypeToJson(_LabelType instance) =>
    <String, dynamic>{'name': instance.name};

_ListItemType _$ListItemTypeFromJson(Map<String, dynamic> json) =>
    _ListItemType(
      id: (json['id'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ListItemTypeToJson(_ListItemType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_ListItemInfoType _$ListItemInfoTypeFromJson(Map<String, dynamic> json) =>
    _ListItemInfoType(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ListItemInfoTypeToJson(_ListItemInfoType instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

_ListType _$ListTypeFromJson(Map<String, dynamic> json) => _ListType(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  isPublic: json['isPublic'] as bool,
  backgroundColor: json['backgroundColor'] as String,
  category: json['category'] as String,
  listItems: (json['listItems'] as List<dynamic>)
      .map((e) => ListItemType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListTypeToJson(_ListType instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'isPublic': instance.isPublic,
  'backgroundColor': instance.backgroundColor,
  'category': instance.category,
  'listItems': instance.listItems.map((e) => e.toJson()).toList(),
};

_AllListType _$AllListTypeFromJson(Map<String, dynamic> json) => _AllListType(
  cursorUpdatedDate: json['cursorUpdatedDate'] as String?,
  hasNext: json['hasNext'] as bool,
  feedLists: (json['feedLists'] as List<dynamic>)
      .map((e) => ListType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllListTypeToJson(_AllListType instance) =>
    <String, dynamic>{
      'cursorUpdatedDate': instance.cursorUpdatedDate,
      'hasNext': instance.hasNext,
      'feedLists': instance.feedLists.map((e) => e.toJson()).toList(),
    };

_ItemType _$ItemTypeFromJson(Map<String, dynamic> json) => _ItemType(
  id: (json['id'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  title: json['title'] as String,
  comment: json['comment'] as String?,
  link: json['link'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ItemTypeToJson(_ItemType instance) => <String, dynamic>{
  'id': instance.id,
  'rank': instance.rank,
  'title': instance.title,
  'comment': instance.comment,
  'link': instance.link,
  'imageUrl': instance.imageUrl,
};

_NewestCommentType _$NewestCommentTypeFromJson(Map<String, dynamic> json) =>
    _NewestCommentType(
      userId: (json['userId'] as num).toInt(),
      userNickname: json['userNickname'] as String,
      userProfileImageUrl: json['userProfileImageUrl'] as String?,
      createdDate: json['createdDate'] as String,
      content: json['content'] as String,
      totalReplyCount: (json['totalReplyCount'] as num).toInt(),
    );

Map<String, dynamic> _$NewestCommentTypeToJson(_NewestCommentType instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'createdDate': instance.createdDate,
      'content': instance.content,
      'totalReplyCount': instance.totalReplyCount,
    };

_Reaction _$ReactionFromJson(Map<String, dynamic> json) => _Reaction(
  reaction: $enumDecode(
    _$ReactionTypeEnumMap,
    json['reaction'],
    unknownValue: ReactionType.unknown,
  ),
  count: (json['count'] as num?)?.toInt(),
  isReacted: json['isReacted'] as bool,
);

Map<String, dynamic> _$ReactionToJson(_Reaction instance) => <String, dynamic>{
  'reaction': _$ReactionTypeEnumMap[instance.reaction]!,
  'count': instance.count,
  'isReacted': instance.isReacted,
};

const _$ReactionTypeEnumMap = {
  ReactionType.cool: 'COOL',
  ReactionType.agree: 'AGREE',
  ReactionType.thanks: 'THANKS',
  ReactionType.unknown: 'unknown',
};

_ListDetailType _$ListDetailTypeFromJson(Map<String, dynamic> json) =>
    _ListDetailType(
      categoryCode: json['categoryCode'] as String,
      categoryEngName: json['categoryEngName'] as String,
      categoryKorName: json['categoryKorName'] as String,
      labels: (json['labels'] as List<dynamic>)
          .map((e) => LabelType.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      description: json['description'] as String?,
      createdDate: json['createdDate'] as String,
      lastUpdatedDate: json['lastUpdatedDate'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerNickname: json['ownerNickname'] as String,
      ownerProfileImageUrl: json['ownerProfileImageUrl'] as String?,
      collaborators: (json['collaborators'] as List<dynamic>)
          .map((e) => CollaboratorType.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemType.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCollected: json['isCollected'] as bool,
      isPublic: json['isPublic'] as bool,
      isFollowing: json['isFollowing'] as bool,
      backgroundPalette: json['backgroundPalette'] as String,
      backgroundColor: json['backgroundColor'] as String,
      collectCount: (json['collectCount'] as num?)?.toInt(),
      viewCount: (json['viewCount'] as num).toInt(),
      updateCount: (json['updateCount'] as num).toInt(),
      totalCommentCount: (json['totalCommentCount'] as num).toInt(),
      newestComment: json['newestComment'] == null
          ? null
          : NewestCommentType.fromJson(
              json['newestComment'] as Map<String, dynamic>,
            ),
      reactions: (json['reactions'] as List<dynamic>)
          .map((e) => Reaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDetailTypeToJson(_ListDetailType instance) =>
    <String, dynamic>{
      'categoryCode': instance.categoryCode,
      'categoryEngName': instance.categoryEngName,
      'categoryKorName': instance.categoryKorName,
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'description': instance.description,
      'createdDate': instance.createdDate,
      'lastUpdatedDate': instance.lastUpdatedDate,
      'ownerId': instance.ownerId,
      'ownerNickname': instance.ownerNickname,
      'ownerProfileImageUrl': instance.ownerProfileImageUrl,
      'collaborators': instance.collaborators.map((e) => e.toJson()).toList(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'isCollected': instance.isCollected,
      'isPublic': instance.isPublic,
      'isFollowing': instance.isFollowing,
      'backgroundPalette': instance.backgroundPalette,
      'backgroundColor': instance.backgroundColor,
      'collectCount': instance.collectCount,
      'viewCount': instance.viewCount,
      'updateCount': instance.updateCount,
      'totalCommentCount': instance.totalCommentCount,
      'newestComment': instance.newestComment?.toJson(),
      'reactions': instance.reactions.map((e) => e.toJson()).toList(),
    };

_SearchListType _$SearchListTypeFromJson(Map<String, dynamic> json) =>
    _SearchListType(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ListItemInfoType.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPublic: json['isPublic'] as bool,
      backgroundColor: json['backgroundColor'] as String,
      updatedDate: json['updatedDate'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerNickname: json['ownerNickname'] as String,
      ownerProfileImageUrl: json['ownerProfileImageUrl'] as String?,
      representImageUrl: json['representImageUrl'] as String?,
      categoryCode: json['categoryCode'] as String,
      categoryKorName: json['categoryKorName'] as String,
      categoryEngName: json['categoryEngName'] as String,
    );

Map<String, dynamic> _$SearchListTypeToJson(_SearchListType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'isPublic': instance.isPublic,
      'backgroundColor': instance.backgroundColor,
      'updatedDate': instance.updatedDate,
      'ownerId': instance.ownerId,
      'ownerNickname': instance.ownerNickname,
      'ownerProfileImageUrl': instance.ownerProfileImageUrl,
      'representImageUrl': instance.representImageUrl,
      'categoryCode': instance.categoryCode,
      'categoryKorName': instance.categoryKorName,
      'categoryEngName': instance.categoryEngName,
    };

_SearchResultType _$SearchResultTypeFromJson(Map<String, dynamic> json) =>
    _SearchResultType(
      resultLists: (json['resultLists'] as List<dynamic>)
          .map((e) => SearchListType.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      cursorId: (json['cursorId'] as num?)?.toInt(),
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$SearchResultTypeToJson(_SearchResultType instance) =>
    <String, dynamic>{
      'resultLists': instance.resultLists.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'cursorId': instance.cursorId,
      'hasNext': instance.hasNext,
    };

_CollectionListType _$CollectionListTypeFromJson(Map<String, dynamic> json) =>
    _CollectionListType(
      id: (json['id'] as num).toInt(),
      backgroundColor: json['backgroundColor'] as String,
      title: json['title'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerNickname: json['ownerNickname'] as String,
      ownerProfileImageUrl: json['ownerProfileImageUrl'] as String?,
      representativeImageUrl: json['representativeImageUrl'] as String?,
      category: json['category'] as String,
      updatedDate: json['updatedDate'] as String,
      listItems: (json['listItems'] as List<dynamic>)
          .map((e) => ListItemType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionListTypeToJson(_CollectionListType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'backgroundColor': instance.backgroundColor,
      'title': instance.title,
      'ownerId': instance.ownerId,
      'ownerNickname': instance.ownerNickname,
      'ownerProfileImageUrl': instance.ownerProfileImageUrl,
      'representativeImageUrl': instance.representativeImageUrl,
      'category': instance.category,
      'updatedDate': instance.updatedDate,
      'listItems': instance.listItems.map((e) => e.toJson()).toList(),
    };

_CollectionType _$CollectionTypeFromJson(Map<String, dynamic> json) =>
    _CollectionType(
      id: (json['id'] as num).toInt(),
      list: CollectionListType.fromJson(json['list'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionTypeToJson(_CollectionType instance) =>
    <String, dynamic>{'id': instance.id, 'list': instance.list.toJson()};

_CollectionListResponseType _$CollectionListResponseTypeFromJson(
  Map<String, dynamic> json,
) => _CollectionListResponseType(
  cursorId: (json['cursorId'] as num?)?.toInt(),
  hasNext: json['hasNext'] as bool,
  collectionLists: (json['collectionLists'] as List<dynamic>)
      .map((e) => CollectionType.fromJson(e as Map<String, dynamic>))
      .toList(),
  folderName: json['folderName'] as String,
);

Map<String, dynamic> _$CollectionListResponseTypeToJson(
  _CollectionListResponseType instance,
) => <String, dynamic>{
  'cursorId': instance.cursorId,
  'hasNext': instance.hasNext,
  'collectionLists': instance.collectionLists.map((e) => e.toJson()).toList(),
  'folderName': instance.folderName,
};
