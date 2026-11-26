import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/history_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/no_data.dart';
import '../../application/history_chart_data.dart';

/// web `HistoryGraph.tsx` 의 Google Charts 옵션 색상.
const historyLineColors = [
  Color(0xFF87CEEB),
  Color(0xFF0000FF),
  Color(0xFF00008B),
  Color(0xFF8A2BE2),
  Color(0xFF32CD32),
  Color(0xFFFFD700),
  Color(0xFFFFA500),
  Color(0xFFFF69B4),
  Color(0xFFFF0000),
  Color(0xFFFF1493),
];

/// 공개 버전의 아이템 순위 변화. 1위가 위에 오도록 y 축을 뒤집는다 (PLAN §11 Q8).
class HistoryGraph extends StatelessWidget {
  const HistoryGraph({super.key, required this.histories});

  final List<HistoryType> histories;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = HistoryChartData.from(histories);
    if (data.isEmpty) return NoDataView(message: l10n.history_empty);
    final count = data.histories.length;

    final chart = LineChart(
      key: const Key('history.chart'),
      LineChartData(
        minX: 0,
        maxX: (count - 1).toDouble().clamp(0.5, double.infinity),
        minY: data.minY,
        maxY: data.maxY,
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value != value.roundToDouble() ||
                    value > HistoryChartData.yOfRank(1) ||
                    value < HistoryChartData.yOfRank(data.maxRank)) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    l10n.history_rank(HistoryChartData.rankOfY(value)),
                    style: context.typo.labelSmall,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final i = value.round();
                if (value != i.toDouble() || i < 0 || i >= count) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    timeDiff(data.histories[i].createdDate, l10n),
                    style: context.typo.labelSmall,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          for (final (i, series) in data.series.indexed)
            LineChartBarData(
              spots: HistoryChartData.spotsOf(series),
              isCurved: true,
              preventCurveOverShooting: true,
              color: historyLineColors[i % historyLineColors.length],
              barWidth: 4,
              dotData: const FlDotData(),
            ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.history_graphTitle, style: context.typo.labelBold),
        const SizedBox(height: 12),
        // web 은 버전마다 100px 이상 폭을 준다.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: LayoutBuilder(
            builder: (context, _) {
              final width = MediaQuery.sizeOf(context).width - 32;
              return SizedBox(
                width: (count * 100.0).clamp(width, double.infinity),
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: chart,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [
            for (final (i, series) in data.series.indexed)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: historyLineColors[i % historyLineColors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    series.title,
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray3,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
