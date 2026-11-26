import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/models/history_type.dart';
import 'package:listywave_app/features/history/application/history_chart_data.dart';
import 'package:listywave_app/features/history/application/history_providers.dart';

import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';
import '../helpers/fixtures.dart';

HistoryType _history(
  int id,
  String date,
  Map<String, int> ranks, {
  bool isPublic = true,
}) => HistoryType(
  id: id,
  createdDate: date,
  isPublic: isPublic,
  items: [
    for (final MapEntry(key: title, value: rank) in ranks.entries)
      HistoryItemType(id: id * 10 + rank, rank: rank, title: title),
  ],
);

void main() {
  group('HistoryChartData (web HistoryGraph.tsx 변환)', () {
    final histories = [
      _history(1, '2024-10-01T00:00:00', {'A': 1, 'B': 2, 'C': 3}),
      _history(2, '2024-10-15T00:00:00', {'B': 1, 'A': 2}, isPublic: false),
      _history(3, '2024-11-01T00:00:00', {'B': 1, 'D': 2, 'A': 3}),
    ];

    test('공개 버전만 쓰고, 아이템을 제목으로 묶어 버전별 순위를 만든다', () {
      final data = HistoryChartData.from(histories);

      expect(data.histories.map((h) => h.id), [1, 3]);
      expect(data.series.map((s) => s.title), ['A', 'B', 'C', 'D']);
      expect(data.series.map((s) => s.ranks), [
        [1, 3],
        [2, 1],
        [3, null],
        [null, 2],
      ]);
      expect(data.maxRank, 3);
    });

    test('y 축을 뒤집는다: 1위가 가장 큰 y (맨 위) 이고 눈금은 순위로 되돌린다', () {
      final data = HistoryChartData.from(histories);
      final a = HistoryChartData.spotsOf(data.series[0]);
      final c = HistoryChartData.spotsOf(data.series[2]);

      expect(a, [const FlSpot(0, -1), const FlSpot(1, -3)]);
      // 그 버전에 없는 아이템은 끊는다.
      expect(c[1], FlSpot.nullSpot);
      expect(
        HistoryChartData.yOfRank(1),
        greaterThan(HistoryChartData.yOfRank(2)),
      );
      expect(HistoryChartData.rankOfY(-3), 3);
      expect(data.maxY, greaterThan(HistoryChartData.yOfRank(1)));
      expect(data.minY, lessThan(HistoryChartData.yOfRank(3)));
    });

    test('공개 버전이 없으면 비어 있다', () {
      expect(HistoryChartData.from([histories[1]]).isEmpty, isTrue);
    });
  });

  group('히스토리 화면', () {
    Future<(ProviderContainer, ApiMock)> openHistory(
      WidgetTester tester, {
      required int userId,
    }) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: userId,
        onMock: (api) {
          api.adapter
            ..onGet(
              '/lists/7/histories',
              (s) => s.reply(200, fixture('histories')),
            )
            ..onPatch('/histories/2', (s) => s.reply(204, null))
            ..onDelete('/histories/2', (s) => s.reply(204, null));
        },
      );
      container.read(routerProvider).push(AppRoutes.listHistory('7'));
      await settle(tester);
      return (container, api);
    }

    testWidgets('그래프 탭은 1위가 위인 LineChart 를 그린다', (tester) async {
      final (_, api) = await openHistory(tester, userId: 9);

      expect(api.sent('GET', '/lists/7/histories'), hasLength(1));
      final chart = tester.widget<LineChart>(
        find.byKey(const Key('history.chart')),
      );
      // 공개 버전 1개(id 2): 카페 어니언 성수 1위, 테일러커피 2위.
      expect(chart.data.lineBarsData, hasLength(2));
      expect(chart.data.lineBarsData[0].spots.single.y, -1);
      expect(chart.data.lineBarsData[1].spots.single.y, -2);
      expect(chart.data.maxY, greaterThan(chart.data.minY));
      expect(find.text('1위'), findsOneWidget);
    });

    testWidgets('주인은 버전을 공개 토글(PATCH)·삭제(DELETE) 할 수 있다', (tester) async {
      final (container, api) = await openHistory(tester, userId: 3);

      await tester.tap(find.text('버전'));
      await settle(tester);
      // 최신 버전(id 2) 이 골라져 있다.
      expect(find.text('2번째 히스토리'), findsOneWidget);

      await tester.tap(find.byKey(const Key('history.togglePublic')));
      await settle(tester);
      expect(api.sent('PATCH', '/histories/2'), hasLength(1));
      expect(
        container
            .read(historiesProvider(7))
            .value!
            .firstWhere((h) => h.id == 2)
            .isPublic,
        isFalse,
      );
      expect(find.text('이 히스토리가 비공개 처리되었습니다.'), findsOneWidget);

      await tester.tap(find.byKey(const Key('history.delete')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('confirmDialog.confirm')));
      await settle(tester);
      expect(api.sent('DELETE', '/histories/2'), hasLength(1));
      expect(api.sent('GET', '/lists/7/histories'), hasLength(2));
    });

    testWidgets('주인이 아니면 공개 버전만 보이고 토글/삭제 버튼이 없다', (tester) async {
      await openHistory(tester, userId: 9);

      await tester.tap(find.text('버전'));
      await settle(tester);

      expect(find.byKey(const Key('history.togglePublic')), findsNothing);
      expect(find.byKey(const Key('history.delete')), findsNothing);
      expect(find.text('1번째 히스토리'), findsOneWidget);
    });
  });
}
