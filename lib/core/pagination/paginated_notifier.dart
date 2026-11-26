import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cursor_page.dart';

/// Tanstack `useInfiniteQuery` 대응 base (PLAN §5.2).
/// 하위 클래스는 [fetchPage] 만 구현한다. 첫 페이지는 cursor 가 null 이다.
abstract class PaginatedNotifier<T, C> extends AsyncNotifier<PageState<T, C>> {
  /// [build] 마다 증가한다. [refresh] 중에 끝난 이전 [loadMore] 결과를 버리는 데 쓴다.
  int _generation = 0;

  Future<CursorPage<T, C>> fetchPage(C? cursor);

  @override
  Future<PageState<T, C>> build() async {
    _generation++;
    final page = await fetchPage(null);
    return PageState(
      items: page.items,
      nextCursor: page.nextCursor,
      hasNext: page.hasNext,
      totalCount: page.totalCount,
    );
  }

  /// 다음 페이지를 붙인다. 마지막 페이지이거나 이미 불러오는 중이면 아무것도 하지 않는다.
  Future<void> loadMore() async {
    final current = state.value;
    if (state.isLoading ||
        current == null ||
        !current.hasNext ||
        current.isLoadingMore) {
      return;
    }
    final generation = _generation;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final page = await fetchPage(current.nextCursor);
      if (generation != _generation) return;
      state = AsyncData(
        PageState(
          items: [...current.items, ...page.items],
          nextCursor: page.nextCursor,
          hasNext: page.hasNext,
          totalCount: page.totalCount ?? current.totalCount,
        ),
      );
    } on Exception catch (e) {
      if (generation != _generation) return;
      state = AsyncData(current.copyWith(loadMoreError: e));
    }
  }

  /// 첫 페이지부터 다시 불러온다.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
