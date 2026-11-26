import 'package:flutter/foundation.dart';

/// cursor 기반 목록 응답 한 페이지. cursor 종류(`cursorUpdatedDate` 문자열, `cursorId`, page 번호)는
/// [C] 로 받는다 (PLAN §5.2, §5.3).
@immutable
class CursorPage<T, C> {
  const CursorPage({
    required this.items,
    required this.nextCursor,
    required this.hasNext,
    this.totalCount,
  });

  final List<T> items;
  final C? nextCursor;
  final bool hasNext;

  /// 응답이 전체 개수를 주면 (댓글, 검색) 그 값. 마지막 페이지의 값을 쓴다.
  final int? totalCount;
}

/// [CursorPage] 를 이어 붙인 화면 상태.
@immutable
class PageState<T, C> {
  const PageState({
    required this.items,
    required this.nextCursor,
    required this.hasNext,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.totalCount,
  });

  final List<T> items;
  final C? nextCursor;
  final bool hasNext;
  final bool isLoadingMore;

  /// 마지막으로 받은 [CursorPage.totalCount].
  final int? totalCount;

  /// 마지막 [PaginatedNotifier.loadMore] 실패. 다음 시도에서 지운다.
  final Object? loadMoreError;

  PageState<T, C> copyWith({bool? isLoadingMore, Object? loadMoreError}) =>
      PageState(
        items: items,
        nextCursor: nextCursor,
        hasNext: hasNext,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        loadMoreError: loadMoreError,
        totalCount: totalCount,
      );
}
