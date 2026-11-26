import 'package:freezed_annotation/freezed_annotation.dart';

part 'requested_topic_type.freezed.dart';
part 'requested_topic_type.g.dart';

// web `src/lib/types/requestedTopicType.ts`. 관리자용 `RequestedTopicsListType`,
// `editAdminTopicType` 은 범위 밖이다. 요청 body `topicType.ts` 는 M4 에서 옮긴다.

/// `GET /topics` 한 개. backend `TopicFindResponse.TopicDto`.
/// `categoryEngName` 은 대문자 enum 이름이다.
@freezed
abstract class RequestedTopicType with _$RequestedTopicType {
  const factory RequestedTopicType({
    required int id,
    required String categoryEngName,
    required String categoryKorName,
    required String categoryCode,
    required String title,
    required String description,
    required String createdDate,
    required int ownerId,
    required String ownerNickname,
    required bool isAnonymous,
    required bool isExposed,
  }) = _RequestedTopicType;

  factory RequestedTopicType.fromJson(Map<String, dynamic> json) =>
      _$RequestedTopicTypeFromJson(json);
}

/// `GET /topics` 응답 (web 은 타입 없음). backend `TopicFindResponse`.
@freezed
abstract class TopicsResponseType with _$TopicsResponseType {
  const factory TopicsResponseType({
    required bool hasNext,
    required int totalCount,
    required int? cursorId,
    required List<RequestedTopicType> topics,
  }) = _TopicsResponseType;

  factory TopicsResponseType.fromJson(Map<String, dynamic> json) =>
      _$TopicsResponseTypeFromJson(json);
}
