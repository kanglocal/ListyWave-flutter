import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

/// web intro Section3~7 (PLAN §6 framer-motion → flutter_animate). 섹션은 lazy [ListView] 가
/// 화면 근처에 올 때 build 하므로 끝까지 스크롤하며 확인한다.
void main() {
  testWidgets('인트로 Section3~7 을 끝까지 그리고, 반복 animation 이 끝나 화면이 안정된다', (
    tester,
  ) async {
    final container = await pumpApp(
      tester,
      beforePump: (c) => mockReadApis(ApiMock(c)),
    );
    container.read(routerProvider).go(AppRoutes.intro);
    await settle(tester);

    final scroll = find.byKey(const Key('intro.scroll'));
    Future<void> scrollTo(Finder target) async {
      await tester.scrollUntilVisible(
        target,
        300,
        scrollable: find.descendant(
          of: scroll,
          matching: find.byType(Scrollable),
        ),
      );
    }

    // Section3: REC 와 제목.
    await scrollTo(find.text('REC'));
    expect(find.text('마음 속 순위로'), findsOneWidget);

    // Section5: 라벨 줄 (24개 중 첫 줄) 과 줄바꿈한 제목 (화면 폭 800 ≥ 395 라 한 줄).
    await scrollTo(find.text('검색으로 쉽게 찾는'));
    expect(find.text('내 최애 연예인 TOP10'), findsOneWidget);

    // Section6: 검색창은 3초마다 다음 예시로 넘어간다.
    await scrollTo(find.text('취향으로 파도타기'));
    expect(find.text('키우기 쉬운 식물 모았어요'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('부산사람의 돼지국밥 맛집 5곳'), findsOneWidget);
    expect(find.text('1.문화교류'), findsOneWidget);

    // Section7: 링크 pill 과 핸드폰 그림.
    await scrollTo(find.text('listywave.com/user/1'));
    expect(find.bySemanticsLabel('핸드폰 이미지'), findsOneWidget);

    // 라벨·카드·하트·REC 의 반복은 정해진 횟수 뒤 멈춘다 (끝없으면 timeout 으로 실패한다).
    await tester.pumpAndSettle(
      const Duration(milliseconds: 500),
      EnginePhase.sendSemanticsUpdate,
      const Duration(minutes: 5),
    );
  });
}
