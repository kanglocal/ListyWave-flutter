import 'package:freezed_annotation/freezed_annotation.dart';

part 'requested_topic_type.freezed.dart';
part 'requested_topic_type.g.dart';

// web `src/lib/types/requestedTopicType.ts`, `topicType.ts`. 관리자용 `RequestedTopicsListType`,
// `editAdminTopicType` 은 범위 밖이다. 요청 body (`TopicCreateType`) 는 `TopicsApi.createTopic` 이 만든다.

/// `GET /topics` 한 개. backend `ExposedTopicFindResponse.TopicDto` (web `TopicType` + id).
/// `categoryEngName` 은 대문자 enum 이름이다.
/// M2 에서는 관리자용 `TopicFindResponse.TopicDto` 모양으로 옮겼는데, 사용자 화면이 부르는
/// `GET /topics` 는 `findAllExposed` 라 categoryCode/createdDate/isExposed 가 없다.
@freezed
abstract class RequestedTopicType with _$RequestedTopicType {
  const factory RequestedTopicType({
    required int id,
    required String categoryEngName,
    required String categoryKorName,
    required String title,
    required String description,
    required int ownerId,
    required String ownerNickname,
    required bool isAnonymous,
  }) = _RequestedTopicType;

  factory RequestedTopicType.fromJson(Map<String, dynamic> json) =>
      _$RequestedTopicTypeFromJson(json);
}

/// `GET /topics` 응답 (web 은 타입 없음). backend `ExposedTopicFindResponse`.
@freezed
abstract class TopicsResponseType with _$TopicsResponseType {
  const factory TopicsResponseType({
    required int? cursorId,
    required bool hasNext,
    required List<RequestedTopicType> topics,
  }) = _TopicsResponseType;

  factory TopicsResponseType.fromJson(Map<String, dynamic> json) =>
      _$TopicsResponseTypeFromJson(json);
}
