import 'package:flutter/widgets.dart';

/// 목록 끝 [threshold] 안으로 들어오면 [onLoadMore] 를 부른다 (PLAN §5.2: 하단 300px 근접,
/// web `useIntersectionObserver` 대체). 내용이 화면보다 짧아 스크롤할 수 없어도 부른다.
class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({
    super.key,
    required this.child,
    required this.onLoadMore,
    required this.canLoadMore,
    this.threshold = 300,
    this.axis = Axis.vertical,
  });

  final Widget child;
  final VoidCallback onLoadMore;

  /// 다음 페이지가 있고 지금 불러오는 중이 아닐 때 true.
  final bool canLoadMore;
  final double threshold;
  final Axis axis;

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  bool _handle(ScrollMetrics metrics) {
    if (metrics.axis == widget.axis &&
        widget.canLoadMore &&
        metrics.extentAfter < widget.threshold) {
      widget.onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      // 첫 layout 과 내용이 바뀐 뒤에도 metrics 가 온다 (짧은 목록 처리).
      onNotification: (n) => n.depth == 0 && _handle(n.metrics),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (n) => n.depth == 0 && _handle(n.metrics),
        child: widget.child,
      ),
    );
  }
}
