import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/pagination/cursor_page.dart';
import 'package:listywave_app/core/pagination/paginated_notifier.dart';

/// cursor 가 문자열(`cursorUpdatedDate`)인 가짜 목록. 3 페이지로 끝난다.
class _FakeFeed extends PaginatedNotifier<int, String> {
  final cursors = <String?>[];
  bool failNext = false;

  static const _pages = {
    null: CursorPage<int, String>(
      items: [1, 2],
      nextCursor: 'd2',
      hasNext: true,
    ),
    'd2': CursorPage<int, String>(
      items: [3, 4],
      nextCursor: 'd4',
      hasNext: true,
    ),
    'd4': CursorPage<int, String>(items: [5], nextCursor: null, hasNext: false),
  };

  @override
  Future<CursorPage<int, String>> fetchPage(String? cursor) async {
    cursors.add(cursor);
    if (failNext) {
      failNext = false;
      throw Exception('network');
    }
    return _pages[cursor]!;
  }
}

final _feedProvider = AsyncNotifierProvider<_FakeFeed, PageState<int, String>>(
  _FakeFeed.new,
);

void main() {
  late ProviderContainer container;
  late _FakeFeed feed;

  setUp(() async {
    container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(_feedProvider, (_, _) {});
    await container.read(_feedProvider.future);
    feed = container.read(_feedProvider.notifier);
  });

  PageState<int, String> state() => container.read(_feedProvider).requireValue;

  test('첫 페이지는 cursor 없이 부르고, loadMore 는 마지막 응답의 cursor 로 전진한다', () async {
    expect(state().items, [1, 2]);
    expect(state().nextCursor, 'd2');

    await feed.loadMore();
    expect(state().items, [1, 2, 3, 4]);
    expect(state().nextCursor, 'd4');

    await feed.loadMore();
    expect(state().items, [1, 2, 3, 4, 5]);
    expect(state().hasNext, isFalse);
    expect(feed.cursors, [null, 'd2', 'd4']);
  });

  test('hasNext=false 면 더 부르지 않는다', () async {
    await feed.loadMore();
    await feed.loadMore();
    await feed.loadMore();
    await feed.loadMore();

    expect(feed.cursors, [null, 'd2', 'd4']);
    expect(state().items, [1, 2, 3, 4, 5]);
  });

  test('불러오는 중에 다시 loadMore 해도 한 번만 부른다', () async {
    await Future.wait([feed.loadMore(), feed.loadMore()]);

    expect(feed.cursors, [null, 'd2']);
    expect(state().items, [1, 2, 3, 4]);
    expect(state().isLoadingMore, isFalse);
  });

  test('refresh 는 첫 페이지부터 다시 불러온다', () async {
    await feed.loadMore();
    await feed.loadMore();

    await feed.refresh();

    expect(state().items, [1, 2]);
    expect(state().nextCursor, 'd2');
    expect(state().hasNext, isTrue);
    expect(feed.cursors, [null, 'd2', 'd4', null]);
  });

  test('loadMore 가 실패하면 목록은 그대로 두고 오류를 남긴다. 다음 시도는 같은 cursor 로 부른다', () async {
    feed.failNext = true;
    await feed.loadMore();

    expect(state().items, [1, 2]);
    expect(state().loadMoreError, isA<Exception>());
    expect(state().isLoadingMore, isFalse);

    await feed.loadMore();
    expect(state().items, [1, 2, 3, 4]);
    expect(state().loadMoreError, isNull);
    expect(feed.cursors, [null, 'd2', 'd2']);
  });
}
