import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/list_detail/presentation/widgets/collaborators.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

void main() {
  late ApiMock api;

  Future<void> pumpDetail(WidgetTester tester, {String listId = '7'}) async {
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    container.read(routerProvider).push(AppRoutes.listDetail(listId));
    await settle(tester);
  }

  testWidgets(
    '/lists/{id} 를 부르고, 댓글 카드를 누르면 /lists/{id}/comments?size=24 를 부른다',
    (tester) async {
      await pumpDetail(tester);

      expect(api.sent('GET', '/lists/7'), hasLength(1));
      expect(find.byType(ListDetailScreen), findsOneWidget);
      expect(find.text('서울 브런치 카페 TOP5'), findsOneWidget);
      expect(find.text('카페 어니언 성수'), findsOneWidget);
      expect(find.text('#성수'), findsOneWidget);
      // 최신 댓글 미리보기. 댓글 목록은 아직 부르지 않는다 (web 과 같이 sheet 를 열 때).
      expect(find.text('어니언 저도 좋아해요!'), findsOneWidget);
      expect(api.sent('GET', '/lists/7/comments'), isEmpty);

      await tester.ensureVisible(find.byKey(const Key('listDetail.comments')));
      await tester.tap(find.byKey(const Key('listDetail.comments')));
      await settle(tester);

      expect(queriesOf(api, '/lists/7/comments'), [
        {'size': '24'},
      ]);
      expect(find.byKey(const Key('comments.list')), findsOneWidget);
      expect(find.text('작성자의 요청으로 삭제된 댓글이에요.'), findsOneWidget);
      expect(find.text('테일러커피 라떼 추천'), findsOneWidget);

      // 답글은 눌러야 펼친다.
      expect(find.text('@빵지순례 팡도르 꼭 드셔보세요'), findsNothing);
      await tester.ensureVisible(
        find.byKey(const Key('comment.33.showReplies')),
      );
      await tester.tap(find.byKey(const Key('comment.33.showReplies')));
      await settle(tester);
      expect(find.text('@빵지순례 팡도르 꼭 드셔보세요'), findsOneWidget);
    },
  );

  testWidgets('자세히 보기는 코멘트, 이미지, YouTube 썸네일, 링크 미리보기를 보인다', (tester) async {
    await pumpDetail(tester);

    await tester.tap(find.byKey(const Key('listDetail.viewType')));
    await settle(tester);
    await tester.tap(find.text('자세히').last);
    await settle(tester);

    expect(find.text('팡도르가 최고'), findsOneWidget);
    expect(find.byKey(const Key('videoEmbed.thumbnail')), findsOneWidget);
    // 일반 링크는 기기에서 직접 og 를 읽는다.
    await tester.scrollUntilVisible(
      find.text('테일러커피 후기'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      api.sent('GET', '/taylor-coffee').single.uri.toString(),
      'https://blog.example.com/taylor-coffee',
    );
    expect(find.text('라떼 맛집'), findsOneWidget);
  });

  testWidgets('협업자를 누르면 협업자 목록이 뜨고, 누르면 그 사람의 마이리스트로 간다', (tester) async {
    await pumpDetail(tester);

    // 리스트 주인(3)은 협업자 목록에서 뺀다.
    await tester.tap(find.byType(Collaborators));
    await settle(tester);

    expect(find.byType(CollaboratorsDialog), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(CollaboratorsDialog),
        matching: find.byType(ListTile),
      ),
      findsNWidgets(2),
    );

    await tester.tap(find.text('빵지순례').last);
    await settle(tester);
    expect(find.byType(UserProfileScreen), findsOneWidget);
  });

  testWidgets('조회에 실패(4xx)하면 재시도 없이 삭제/비공개 안내를 보인다', (tester) async {
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
        api.adapter.onGet(
          '/lists/404',
          (s) => s.reply(404, {
            'status': 404,
            'error': 'NOT_FOUND',
            'code': 'RESOURCE_NOT_FOUND',
            'detail': '리스트가 없습니다.',
            'message': '리스트가 없습니다.',
          }),
        );
      },
    );
    container.read(routerProvider).push(AppRoutes.listDetail('404'));
    await settle(tester);

    expect(api.sent('GET', '/lists/404'), hasLength(1));
    expect(find.text('이 리스트는 삭제 또는 비공개 처리 되었어요.'), findsOneWidget);
  });
}
