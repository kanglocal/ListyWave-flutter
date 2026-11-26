import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/notice/presentation/notice_detail_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_list_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

void main() {
  late ApiMock api;

  Future<void> pumpAt(WidgetTester tester, String location) async {
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    container.read(routerProvider).go(location);
    await settle(tester);
  }

  testWidgets('공지 목록은 /notices 를 부르고, 누르면 상세로 간다', (tester) async {
    await pumpAt(tester, AppRoutes.notice);

    expect(find.byType(NoticeListScreen), findsOneWidget);
    expect(api.sent('GET', '/notices'), hasLength(1));
    expect(find.text('리스티웨이브 앱 출시 안내'), findsOneWidget);
    expect(find.text('2024-11-01'), findsOneWidget);

    await tester.tap(find.text('리스티웨이브 앱 출시 안내'));
    await settle(tester);
    expect(find.byType(NoticeDetailScreen), findsOneWidget);
    expect(api.sent('GET', '/notices/4'), hasLength(1));
  });

  testWidgets('공지 상세는 /notices/{id} 를 부르고 블록을 종류별로 그린다 (body 는 markdown)', (
    tester,
  ) async {
    await pumpAt(tester, AppRoutes.noticeDetail('4'));

    expect(api.sent('GET', '/notices/4'), hasLength(1));
    expect(find.text('앱 출시'), findsOneWidget);
    expect(find.byType(MarkdownBody), findsOneWidget);
    expect(find.text('다운로드'), findsOneWidget);
    expect(find.text('문의는 listywave8@gmail.com 으로 보내주세요.'), findsOneWidget);
    // 이전 글은 있고 다음 글은 없다.
    expect(find.text('이전글'), findsOneWidget);
    expect(find.text('다음글'), findsNothing);
  });
}
