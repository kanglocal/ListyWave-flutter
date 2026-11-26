import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_type.freezed.dart';
part 'history_type.g.dart';

/// backend `HistorySearchResponse.HistoryItemInfo`.
@freezed
abstract class HistoryItemType with _$HistoryItemType {
  const factory HistoryItemType({
    required int id,
    required int rank,
    required String title,
  }) = _HistoryItemType;

  factory HistoryItemType.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemTypeFromJson(json);
}

/// web `src/lib/types/historyType.ts` · backend `HistorySearchResponse`.
/// 날짜는 서버 문자열 그대로 둔다 (PLAN §5.3).
@freezed
abstract class HistoryType with _$HistoryType {
  const factory HistoryType({
    required int id,
    required String createdDate,
    required bool isPublic,
    required List<HistoryItemType> items,
  }) = _HistoryType;

  factory HistoryType.fromJson(Map<String, dynamic> json) =>
      _$HistoryTypeFromJson(json);
}
