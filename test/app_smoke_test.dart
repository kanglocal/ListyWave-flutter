import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/app_shell.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/intro/presentation/intro_screen.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('앱은 하단 탭이 있는 HomeScreen 으로 시작한다', (tester) async {
    await pumpApp(tester);

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(AppBottomNav), findsOneWidget);
    // 홈 화면 제목도 "홈" 이라 (web Header.tsx) 하단 탭 안에서 찾는다.
    final bottomNav = find.byType(AppBottomNav);
    expect(
      find.descendant(of: bottomNav, matching: find.text('홈')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNav, matching: find.text('내 피드')),
      findsOneWidget,
    );
  });

  testWidgets('비로그인 상태에서 내 피드 / 추가를 누르면 로그인 dialog 가 뜬다', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('내 피드'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginSheet), findsOneWidget);

    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginSheet), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key('bottomNav.add')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginSheet), findsOneWidget);
  });

  testWidgets('하단 탭은 web 과 같이 / 와 /mylist 에서만 보인다', (tester) async {
    final container = await pumpLoggedInApp(tester, userId: 3);
    final router = container.read(routerProvider);

    router.go(AppRoutes.listCreate);
    await tester.pumpAndSettle();
    expect(find.byType(AppBottomNav), findsNothing);

    router.go(AppRoutes.myList('3'));
    await tester.pumpAndSettle();
    expect(find.byType(AppBottomNav), findsOneWidget);

    router.go(AppRoutes.intro);
    await tester.pumpAndSettle();
    expect(find.byType(IntroScreen), findsOneWidget);
    expect(find.byType(AppBottomNav), findsNothing);
  });
}
