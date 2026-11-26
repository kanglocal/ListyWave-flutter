import 'package:fl_chart/fl_chart.dart';

import '../../../core/models/history_type.dart';

/// 아이템 하나의 버전별 순위. 그 버전에 없으면 null 이다 (web `HistoryGraph.tsx` ItemType).
typedef RankSeries = ({String title, List<int?> ranks});

/// web `HistoryGraph.tsx` 의 데이터 변환. 공개 버전만 쓰고, 아이템은 제목으로 묶는다.
class HistoryChartData {
  HistoryChartData._(this.histories, this.series, this.maxRank);

  factory HistoryChartData.from(List<HistoryType> histories) {
    final public = histories.where((h) => h.isPublic).toList();
    final titles = <String>[];
    var maxRank = 1;
    for (final h in public) {
      for (final item in h.items) {
        if (!titles.contains(item.title)) titles.add(item.title);
        if (item.rank > maxRank) maxRank = item.rank;
      }
    }
    final series = [
      for (final title in titles)
        (
          title: title,
          ranks: [
            for (final h in public)
              h.items.where((i) => i.title == title).firstOrNull?.rank,
          ],
        ),
    ];
    return HistoryChartData._(public, series, maxRank);
  }

  /// 그래프에 그리는 (공개) 버전. x 축 순서다.
  final List<HistoryType> histories;
  final List<RankSeries> series;

  /// 가장 낮은 순위 (가장 큰 숫자).
  final int maxRank;

  bool get isEmpty => histories.isEmpty;

  /// web 은 Google Charts `vAxis.direction: -1` 로 1위를 위에 둔다. fl_chart 에는 축 반전이
  /// 없어서 y = -rank 로 그리고, 눈금 글자는 [rankOfY] 로 되돌린다.
  static double yOfRank(int rank) => -rank.toDouble();

  static int rankOfY(double y) => -y.round();

  /// 1위가 맨 위 (가장 큰 y).
  double get maxY => yOfRank(1) + 0.3;

  double get minY => yOfRank(maxRank) - 0.3;

  /// [series] 의 점. 그 버전에 없는 아이템은 끊어 그린다 ([FlSpot.nullSpot]).
  static List<FlSpot> spotsOf(RankSeries series) => [
    for (final (index, rank) in series.ranks.indexed)
      rank == null ? FlSpot.nullSpot : FlSpot(index.toDouble(), yOfRank(rank)),
  ];
}
