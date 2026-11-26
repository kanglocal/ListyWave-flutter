import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_type.freezed.dart';
part 'home_type.g.dart';

// web `src/lib/types/homeType.ts`.

/// web `Top3Type` · backend `RecommendedListResponse.Top3ItemResponse`.
@freezed
abstract class Top3Type with _$Top3Type {
  const factory Top3Type({
    required int id,
    required int rank,
    required String title,
  }) = _Top3Type;

  factory Top3Type.fromJson(Map<String, dynamic> json) =>
      _$Top3TypeFromJson(json);
}

/// `GET /lists/recommend` 한 개. backend `RecommendedListResponse`.
@freezed
abstract class HomeRecommendedListType with _$HomeRecommendedListType {
  const factory HomeRecommendedListType({
    required int id,
    required int ownerId,
    required String ownerNickname,
    required String title,

    /// 대표 이미지. 없으면 null 또는 빈 문자열이다.
    required String? itemImageUrl,

    /// 카테고리 한글 이름 (`CategoryType.viewName`).
    required String category,
    required String backgroundColor,
    required List<Top3Type> items,
  }) = _HomeRecommendedListType;

  factory HomeRecommendedListType.fromJson(Map<String, dynamic> json) =>
      _$HomeRecommendedListTypeFromJson(json);
}

/// web `UsersRecommendationItemType` · backend `UsersRecommendedResponse`.
@freezed
abstract class UsersRecommendationItemType with _$UsersRecommendationItemType {
  const factory UsersRecommendationItemType({
    required int id,
    required String nickname,
    required String? profileImageUrl,
  }) = _UsersRecommendationItemType;

  factory UsersRecommendationItemType.fromJson(Map<String, dynamic> json) =>
      _$UsersRecommendationItemTypeFromJson(json);
}

/// web `homeType.ts` `ListItemType` · backend `ListRecentResponse.ItemsResponse`.
/// `listType.ts` 의 `ListItemType` 과 이름이 겹쳐 `Home` 을 붙였다.
@freezed
abstract class HomeListItemType with _$HomeListItemType {
  const factory HomeListItemType({
    required int id,
    required int rank,
    required String title,
  }) = _HomeListItemType;

  factory HomeListItemType.fromJson(Map<String, dynamic> json) =>
      _$HomeListItemTypeFromJson(json);
}

/// 최신/팔로잉 피드 한 개 (`GET /lists`, `/lists/following`). backend `ListRecentResponse.ListResponse`.
/// web `ListRecommendationType` 의 category/backgroundColor/listUrl/labels/version 은
/// backend 가 주지 않아 뺐고, backend 의 `updateCount` 를 넣었다.
@freezed
abstract class ListRecommendationType with _$ListRecommendationType {
  const factory ListRecommendationType({
    required int id,
    required int ownerId,
    required String ownerNickname,
    required String? ownerProfileImage,
    required String title,
    required String? description,
    required List<HomeListItemType> items,
    required int updateCount,
  }) = _ListRecommendationType;

  factory ListRecommendationType.fromJson(Map<String, dynamic> json) =>
      _$ListRecommendationTypeFromJson(json);
}

/// `GET /lists`, `/lists/following` 응답 (web 은 타입 없음). backend `ListRecentResponse`.
@freezed
abstract class FeedListsType with _$FeedListsType {
  const factory FeedListsType({
    required bool hasNext,

    /// 다음 페이지 cursor. 파싱하지 않고 그대로 돌려보낸다 (PLAN §5.3).
    required String? cursorUpdatedDate,
    required List<ListRecommendationType> lists,
  }) = _FeedListsType;

  factory FeedListsType.fromJson(Map<String, dynamic> json) =>
      _$FeedListsTypeFromJson(json);
}

/// `GET /topics/recommend` 한 개. backend `RecommendTopicFindResponse` 는 web 에 없는
/// `categoryKorName` 을 더 준다.
@freezed
abstract class RecommendedTopicType with _$RecommendedTopicType {
  const factory RecommendedTopicType({
    required int id,
    required String title,
    required String categoryKorName,
  }) = _RecommendedTopicType;

  factory RecommendedTopicType.fromJson(Map<String, dynamic> json) =>
      _$RecommendedTopicTypeFromJson(json);
}
