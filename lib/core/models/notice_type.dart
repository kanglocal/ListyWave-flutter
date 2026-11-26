// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_type.freezed.dart';
part 'notice_type.g.dart';

// web `src/lib/types/noticeType.ts` 의 사용자용 타입. 관리자 타입
// (NoticeCategoryType, NoticeCreateType, AdminNoticeType) 은 범위 밖이다 (PLAN §1.3).

/// 공지 본문 블록 종류. backend `ContentType` 을 소문자로 준다.
@JsonEnum()
enum NoticeContentsType {
  subtitle,
  body,
  image,
  button,
  line,
  note,

  /// 앱이 모르는 블록. 그리지 않는다.
  unknown,
}

/// `GET /notices` 한 개. backend `NoticeFindAllResponseToUser`.
@freezed
abstract class NoticeListItemType with _$NoticeListItemType {
  const factory NoticeListItemType({
    required int id,
    required String createdDate,
    required String title,
    required String? itemImageUrl,

    /// 카테고리 표시 이름 (소식/이벤트/팁).
    required String category,
    required String description,
  }) = _NoticeListItemType;

  factory NoticeListItemType.fromJson(Map<String, dynamic> json) =>
      _$NoticeListItemTypeFromJson(json);
}

/// backend `NoticeFindResponse.ContentDto`.
@freezed
abstract class NoticeContentType with _$NoticeContentType {
  const factory NoticeContentType({
    @JsonKey(unknownEnumValue: NoticeContentsType.unknown)
    required NoticeContentsType type,
    required String? description,
    required String? imageUrl,
    required String? buttonName,
    required String? buttonLink,
  }) = _NoticeContentType;

  factory NoticeContentType.fromJson(Map<String, dynamic> json) =>
      _$NoticeContentTypeFromJson(json);
}

/// 이전/다음 공지. backend `NoticeFindResponse.BesideNoticeDto` (web `Partial<NoticeType>`).
@freezed
abstract class BesideNoticeType with _$BesideNoticeType {
  const factory BesideNoticeType({
    required int id,
    required String title,
    required String description,
  }) = _BesideNoticeType;

  factory BesideNoticeType.fromJson(Map<String, dynamic> json) =>
      _$BesideNoticeTypeFromJson(json);
}

/// `GET /notices/{noticeId}`. backend `NoticeFindResponse`.
@freezed
abstract class NoticeDetailType with _$NoticeDetailType {
  const factory NoticeDetailType({
    required int id,
    required String category,
    required String title,
    required String description,
    required List<NoticeContentType> contents,
    required String createdDate,
    required BesideNoticeType? prevNotice,
    required BesideNoticeType? nextNotice,
  }) = _NoticeDetailType;

  factory NoticeDetailType.fromJson(Map<String, dynamic> json) =>
      _$NoticeDetailTypeFromJson(json);
}
