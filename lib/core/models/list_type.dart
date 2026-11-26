// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'comment_type.dart';
import 'reaction_type.dart';

part 'list_type.freezed.dart';
part 'list_type.g.dart';

// web `src/lib/types/listType.ts` 의 응답 타입. 생성/수정 요청 타입
// (ItemCreateType, ListCreateType, ListEditType, ItemImage(s)Type, PresignedUrlType) 은
// 쓰는 화면이 생기는 M4 에서 옮긴다.

/// 리스트 상세의 라벨. backend `ListDetailResponse.LabelResponse` (name 만 있다).
@freezed
abstract class LabelType with _$LabelType {
  const factory LabelType({required String name}) = _LabelType;

  factory LabelType.fromJson(Map<String, dynamic> json) =>
      _$LabelTypeFromJson(json);
}

/// 목록 카드의 아이템. backend `FindFeedListResponse.ListItemsResponse`,
/// `CollectionFindResponse.ListItemsDto`.
@freezed
abstract class ListItemType with _$ListItemType {
  const factory ListItemType({
    required int id,
    required int rank,
    required String title,
    required String? imageUrl,
  }) = _ListItemType;

  factory ListItemType.fromJson(Map<String, dynamic> json) =>
      _$ListItemTypeFromJson(json);
}

/// 검색 결과 카드의 아이템. backend `ListSearchResponse.ItemInfo` 는 id/title 만 준다
/// (web 은 `ListItemType` 으로 받는다).
@freezed
abstract class ListItemInfoType with _$ListItemInfoType {
  const factory ListItemInfoType({required int id, required String title}) =
      _ListItemInfoType;

  factory ListItemInfoType.fromJson(Map<String, dynamic> json) =>
      _$ListItemInfoTypeFromJson(json);
}

/// 유저 리스트 한 개. backend `FindFeedListResponse.FeedListInfo`.
@freezed
abstract class ListType with _$ListType {
  const factory ListType({
    required int id,
    required String title,
    required bool isPublic,
    required String backgroundColor,

    /// 카테고리 한글 이름.
    required String category,
    required List<ListItemType> listItems,
  }) = _ListType;

  factory ListType.fromJson(Map<String, dynamic> json) =>
      _$ListTypeFromJson(json);
}

/// `GET /users/{userId}/lists` 응답. backend `FindFeedListResponse`.
@freezed
abstract class AllListType with _$AllListType {
  const factory AllListType({
    required String? cursorUpdatedDate,
    required bool hasNext,
    required List<ListType> feedLists,
  }) = _AllListType;

  factory AllListType.fromJson(Map<String, dynamic> json) =>
      _$AllListTypeFromJson(json);
}

/// 리스트 상세 아이템. backend `ListDetailResponse.ItemResponse`.
@freezed
abstract class ItemType with _$ItemType {
  const factory ItemType({
    required int id,
    required int rank,
    required String title,
    required String? comment,
    required String? link,
    required String? imageUrl,
  }) = _ItemType;

  factory ItemType.fromJson(Map<String, dynamic> json) =>
      _$ItemTypeFromJson(json);
}

/// backend `ListDetailResponse.NewestComment`.
@freezed
abstract class NewestCommentType with _$NewestCommentType {
  const factory NewestCommentType({
    required int userId,
    required String userNickname,
    required String? userProfileImageUrl,
    required String createdDate,
    required String content,
    required int totalReplyCount,
  }) = _NewestCommentType;

  factory NewestCommentType.fromJson(Map<String, dynamic> json) =>
      _$NewestCommentTypeFromJson(json);
}

/// backend `ReactionResponse`. `count` 는 리스트 주인에게만 준다 (아니면 null).
@freezed
abstract class Reaction with _$Reaction {
  const factory Reaction({
    @JsonKey(unknownEnumValue: ReactionType.unknown)
    required ReactionType reaction,
    required int? count,
    required bool isReacted,
  }) = _Reaction;

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);
}

/// `GET /lists/{listId}`. backend `ListDetailResponse`.
/// web 의 `id?` 는 backend 가 주지 않아 뺐고, backend 의 `categoryCode` 를 넣었다.
@freezed
abstract class ListDetailType with _$ListDetailType {
  const factory ListDetailType({
    required String categoryCode,
    required String categoryEngName,
    required String categoryKorName,
    required List<LabelType> labels,
    required String title,
    required String? description,
    required String createdDate,
    required String lastUpdatedDate,
    required int ownerId,
    required String ownerNickname,
    required String? ownerProfileImageUrl,
    required List<CollaboratorType> collaborators,
    required List<ItemType> items,
    required bool isCollected,
    required bool isPublic,
    required bool isFollowing,
    required String backgroundPalette,
    required String backgroundColor,

    /// 리스트 주인에게만 준다.
    required int? collectCount,
    required int viewCount,
    required int updateCount,
    required int totalCommentCount,
    required NewestCommentType? newestComment,
    required List<Reaction> reactions,
  }) = _ListDetailType;

  factory ListDetailType.fromJson(Map<String, dynamic> json) =>
      _$ListDetailTypeFromJson(json);
}

/// 검색 결과 리스트. backend `ListSearchResponse.ListDto`. web 의 `listItems` 는 backend 에 없다.
/// `categoryEngName` 은 다른 응답과 달리 대문자 enum 이름이다.
@freezed
abstract class SearchListType with _$SearchListType {
  const factory SearchListType({
    required int id,
    required String title,
    required List<ListItemInfoType> items,
    required bool isPublic,
    required String backgroundColor,
    required String updatedDate,
    required int ownerId,
    required String ownerNickname,
    required String? ownerProfileImageUrl,
    required String? representImageUrl,
    required String categoryCode,
    required String categoryKorName,
    required String categoryEngName,
  }) = _SearchListType;

  factory SearchListType.fromJson(Map<String, dynamic> json) =>
      _$SearchListTypeFromJson(json);
}

/// `GET /lists/search`. backend `ListSearchResponse`.
@freezed
abstract class SearchResultType with _$SearchResultType {
  const factory SearchResultType({
    required List<SearchListType> resultLists,
    required int totalCount,
    required int? cursorId,
    required bool hasNext,
  }) = _SearchResultType;

  factory SearchResultType.fromJson(Map<String, dynamic> json) =>
      _$SearchResultTypeFromJson(json);
}

/// backend `CollectionFindResponse.ListsDto`.
@freezed
abstract class CollectionListType with _$CollectionListType {
  const factory CollectionListType({
    required int id,
    required String backgroundColor,
    required String title,
    required int ownerId,
    required String ownerNickname,
    required String? ownerProfileImageUrl,
    required String? representativeImageUrl,
    required String category,
    required String updatedDate,
    required List<ListItemType> listItems,
  }) = _CollectionListType;

  factory CollectionListType.fromJson(Map<String, dynamic> json) =>
      _$CollectionListTypeFromJson(json);
}

/// backend `CollectionFindResponse.CollectionDto`.
@freezed
abstract class CollectionType with _$CollectionType {
  const factory CollectionType({
    required int id,
    required CollectionListType list,
  }) = _CollectionType;

  factory CollectionType.fromJson(Map<String, dynamic> json) =>
      _$CollectionTypeFromJson(json);
}

/// `GET /folder/{folderId}/collections`. web `_api/collect/getCollection.ts`
/// `CollectionListResponseType` 은 `cursorId: string` 이지만 backend 는 Long 이다.
@freezed
abstract class CollectionListResponseType with _$CollectionListResponseType {
  const factory CollectionListResponseType({
    required int? cursorId,
    required bool hasNext,
    required List<CollectionType> collectionLists,
    required String folderName,
  }) = _CollectionListResponseType;

  factory CollectionListResponseType.fromJson(Map<String, dynamic> json) =>
      _$CollectionListResponseTypeFromJson(json);
}
