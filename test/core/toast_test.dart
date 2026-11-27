import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/widgets/toast.dart';

void main() {
  testWidgets('이용 정지 안내가 떠 있는 3초 동안은 화면별 실패 안내로 덮지 않는다', (tester) async {
    var now = DateTime(2026, 11, 27, 12);
    debugResetToast(clock: () => now);
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        scaffoldMessengerKey: messengerKey,
        home: Scaffold(
          body: Builder(
            builder: (c) {
              context = c;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    showSuspendedNotice(messengerKey.currentState!, '정지 안내');
    await tester.pump();
    showToast(context, '댓글 처리에 실패했어요');
    await tester.pump();
    expect(find.text('정지 안내'), findsOneWidget);
    expect(find.text('댓글 처리에 실패했어요'), findsNothing);

    now = now.add(const Duration(seconds: 3));
    showToast(context, '다른 안내');
    await tester.pumpAndSettle();
    expect(find.text('다른 안내'), findsOneWidget);
  });
}
