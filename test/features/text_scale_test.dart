import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/account/presentation/account_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/list_editor/presentation/list_create_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

/// 큰 글씨 (시스템 글자 크기 200%) 를 폰 크기 화면 (iPhone 15, 393x852) 에서 그린다.
/// RenderFlex overflow 는 flutter_test 가 오류로 보고하므로 [WidgetTester.takeException] 으로
/// 한 번 더 확인한다.
void _useLargeTextOnPhone(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(1179, 2556)
    ..devicePixelRatio = 3;
  tester.platformDispatcher.textScaleFactorTestValue = 2;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

void _expectScaledWithoutOverflow(WidgetTester tester, Type screen) {
  expect(find.byType(screen), findsOneWidget);
  expect(
    MediaQuery.textScalerOf(tester.element(find.byType(screen))).scale(10),
    20,
  );
  expect(tester.takeException(), isNull);
}

void main() {
  testWidgets('홈 (추천 탭) 은 글자 크기 200% 에서도 넘치지 않는다', (tester) async {
    _useLargeTextOnPhone(tester);
    await pumpWithApi(tester);
    await settle(tester);

    _expectScaledWithoutOverflow(tester, HomeScreen);
  });

  testWidgets('홈 (최신 탭) 은 글자 크기 200% 에서도 넘치지 않는다', (tester) async {
    _useLargeTextOnPhone(tester);
    await pumpWithApi(tester);
    await settle(tester);
    await tester.tap(find.byKey(const Key('homeTab.recent')));
    await settle(tester);

    _expectScaledWithoutOverflow(tester, HomeScreen);
  });

  testWidgets('리스트 상세는 글자 크기 200% 에서도 넘치지 않는다', (tester) async {
    _useLargeTextOnPhone(tester);
    final (container, _) = await pumpWithApi(tester);
    container.read(routerProvider).push(AppRoutes.listDetail('7'));
    await settle(tester);

    _expectScaledWithoutOverflow(tester, ListDetailScreen);
    expect(find.text('서울 브런치 카페 TOP5'), findsWidgets);
  });

  testWidgets('리스트 만들기 1단계는 글자 크기 200% 에서도 넘치지 않는다', (tester) async {
    _useLargeTextOnPhone(tester);
    final (container, _) = await pumpWithApi(tester, userId: 9);
    container.read(routerProvider).push(AppRoutes.listCreate);
    await settle(tester);

    _expectScaledWithoutOverflow(tester, ListCreateScreen);
  });

  testWidgets('계정 화면은 글자 크기 200% 에서도 넘치지 않는다', (tester) async {
    _useLargeTextOnPhone(tester);
    final (container, _) = await pumpWithApi(tester, userId: 9);
    container.read(routerProvider).push(AppRoutes.account);
    await settle(tester);

    _expectScaledWithoutOverflow(tester, AccountScreen);
  });
}
