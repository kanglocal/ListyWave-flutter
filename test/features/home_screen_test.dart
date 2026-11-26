import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

void main() {
  late ApiMock api;

  Future<void> pumpHome(WidgetTester tester) async {
    await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    await settle(tester);
  }

  testWidgets(
    '추천 탭은 /lists/recommend, /users/recommend, /topics/recommend 를 부른다',
    (tester) async {
      await pumpHome(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(api.sent('GET', '/lists/recommend'), hasLength(1));
      expect(api.sent('GET', '/users/recommend'), hasLength(1));
      expect(api.sent('GET', '/topics/recommend'), hasLength(1));
      // 비로그인이라 Authorization 이 없다.
      expect(api.requests.map(authorizationOf).whereType<String>(), isEmpty);

      // swiper, 추천 주제, 추천 리스터.
      expect(find.text('서울 브런치 카페 TOP5'), findsWidgets);
      expect(find.text('내 인생 최고의 드라마'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('추천 리스터'),
        200,
        scrollable: find
            .descendant(
              of: find.byKey(const Key('home.recommendation')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      expect(find.text('빵지순례'), findsOneWidget);
    },
  );

  testWidgets(
    '최신 탭은 /lists?size=10 을 부르고, 끝까지 스크롤하면 마지막 응답의 cursorUpdatedDate 로 다음 페이지를 부른다',
    (tester) async {
      await pumpHome(tester);

      await tester.tap(find.byKey(const Key('homeTab.recent')));
      await settle(tester);

      expect(queriesOf(api, '/lists'), [
        {'size': '10', 'category': 'entire'},
      ]);
      expect(api.sent('GET', '/categories'), hasLength(1));
      expect(find.text('요즘 듣는 노래 1'), findsOneWidget);

      // 목록 끝까지 내린다.
      final feed = find
          .descendant(
            of: find.byKey(const Key('home.feed')),
            matching: find.byType(Scrollable),
          )
          .first;
      await tester.scrollUntilVisible(
        find.text('요즘 듣는 노래 12'),
        500,
        scrollable: feed,
      );
      await settle(tester);

      final cursor = fixtureMap('lists_recent_page1')['cursorUpdatedDate'];
      expect(queriesOf(api, '/lists'), [
        {'size': '10', 'category': 'entire'},
        {'size': '10', 'cursorUpdatedDate': cursor, 'category': 'entire'},
      ]);
      // 마지막 페이지(hasNext=false) 뒤에는 더 부르지 않고 끝 안내를 보인다.
      await tester.scrollUntilVisible(
        find.text('최근 리스트를 모두 확인했어요!'),
        300,
        scrollable: feed,
      );
      expect(queriesOf(api, '/lists'), hasLength(2));
    },
  );

  testWidgets('최신 탭에서 카테고리를 고르면 그 category 로 다시 부른다', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.byKey(const Key('homeTab.recent')));
    await settle(tester);

    await tester.tap(find.byKey(const Key('category.1')));
    await settle(tester);

    expect(queriesOf(api, '/lists').last, {'size': '10', 'category': 'music'});
  });

  testWidgets('비로그인으로 팔로잉 탭을 열면 요청 없이 로그인 안내를 보인다', (tester) async {
    await pumpHome(tester);

    await tester.tap(find.byKey(const Key('homeTab.following')));
    await settle(tester);

    expect(api.sent('GET', '/lists/following'), isEmpty);
    expect(find.text('로그인하여 좋아하는 리스터를 팔로우하세요 🩵'), findsOneWidget);

    await tester.tap(find.text('로그인 하러가기'));
    await settle(tester);
    expect(find.byType(LoginSheet), findsOneWidget);
  });

  testWidgets('로그인하면 팔로잉 탭이 /lists/following?size=10 을 부른다', (tester) async {
    final container = await pumpLoggedInApp(tester);
    final mock = ApiMock(container);
    mockReadApis(mock);
    container.read(routerProvider).go(AppRoutes.home);
    await settle(tester);

    await tester.tap(find.byKey(const Key('homeTab.following')));
    await settle(tester);

    expect(queriesOf(mock, '/lists/following'), [
      {'size': '10'},
    ]);
    expect(find.text('요즘 듣는 노래 21'), findsOneWidget);
  });

  testWidgets('추천 리스트를 누르면 리스트 상세로 간다', (tester) async {
    await pumpHome(tester);

    await tester.tap(find.text('서울 브런치 카페 TOP5').hitTestable().first);
    await settle(tester);

    expect(api.sent('GET', '/lists/101'), hasLength(1));
  });
}
