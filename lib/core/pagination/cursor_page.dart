import 'package:flutter/foundation.dart';

/// cursor 기반 목록 응답 한 페이지. cursor 종류(`cursorUpdatedDate` 문자열, `cursorId`, page 번호)는
/// [C] 로 받는다 (PLAN §5.2, §5.3).
@immutable
class CursorPage<T, C> {
  const CursorPage({
    required this.items,
    required this.nextCursor,
    required this.hasNext,
  });

  final List<T> items;
  final C? nextCursor;
  final bool hasNext;
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
  });

  final List<T> items;
  final C? nextCursor;
  final bool hasNext;
  final bool isLoadingMore;

  /// 마지막 [PaginatedNotifier.loadMore] 실패. 다음 시도에서 지운다.
  final Object? loadMoreError;

  PageState<T, C> copyWith({bool? isLoadingMore, Object? loadMoreError}) =>
      PageState(
        items: items,
        nextCursor: nextCursor,
        hasNext: hasNext,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        loadMoreError: loadMoreError,
      );
}
