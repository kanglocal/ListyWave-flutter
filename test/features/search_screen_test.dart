import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/search/presentation/search_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

void main() {
  late ApiMock api;

  Future<void> pumpSearch(WidgetTester tester, String location) async {
    final container = await pumpApp(
      tester,
      beforePump: (c) {
        api = ApiMock(c);
        mockReadApis(api);
      },
    );
    container.read(routerProvider).push(location);
    await settle(tester);
  }

  testWidgets(
    'keyword 가 있으면 sort=related 로 /lists/search?keyword&sort&categoryCode&size=6 을 부른다',
    (tester) async {
      await pumpSearch(tester, '/search?keyword=맛집&categoryCode=5');

      expect(find.byType(SearchScreen), findsOneWidget);
      expect(queriesOf(api, '/lists/search'), [
        {'keyword': '맛집', 'sort': 'related', 'categoryCode': '5', 'size': '6'},
      ]);
      // 전체 카테고리가 아니면 유저 검색을 하지 않는다 (web SearchResult.tsx).
      expect(api.sent('GET', '/users'), isEmpty);
      expect(find.text('맛집 리스트 1'), findsOneWidget);
      expect(find.text('2건'), findsOneWidget);
    },
  );

  testWidgets('keyword 가 없으면 sort=new, categoryCode=0 이다', (tester) async {
    await pumpSearch(tester, AppRoutes.search);

    expect(queriesOf(api, '/lists/search'), [
      {'keyword': '', 'sort': 'new', 'categoryCode': '0', 'size': '6'},
    ]);
  });

  testWidgets('전체 카테고리에서 keyword 가 있으면 /users?search&size=3 으로 리스터도 찾는다', (
    tester,
  ) async {
    await pumpSearch(tester, '/search?keyword=맛집&categoryCode=0');

    expect(queriesOf(api, '/users'), [
      {'search': '맛집', 'size': '3'},
    ]);
    expect(find.text('맛집탐방러'), findsOneWidget);
  });

  testWidgets('입력은 debounce 뒤에 한 번만 검색하고, 엔터는 바로 검색한다', (tester) async {
    await pumpSearch(tester, '/search?categoryCode=5');
    expect(queriesOf(api, '/lists/search'), hasLength(1));

    await tester.enterText(find.byKey(const Key('search.keyword')), '빵');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.enterText(find.byKey(const Key('search.keyword')), '빵집');
    await tester.pump(const Duration(milliseconds: 200));
    expect(queriesOf(api, '/lists/search'), hasLength(1));

    await tester.pump(SearchScreen.debounce);
    await settle(tester);
    expect(queriesOf(api, '/lists/search'), [
      {'keyword': '', 'sort': 'new', 'categoryCode': '5', 'size': '6'},
      {'keyword': '빵집', 'sort': 'related', 'categoryCode': '5', 'size': '6'},
    ]);

    await tester.enterText(find.byKey(const Key('search.keyword')), '카페');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    await settle(tester);
    expect(queriesOf(api, '/lists/search').last['keyword'], '카페');
    expect(queriesOf(api, '/lists/search'), hasLength(3));
  });

  testWidgets('카테고리와 정렬을 바꾸면 그 값으로 다시 부른다', (tester) async {
    await pumpSearch(tester, '/search?keyword=맛집&categoryCode=0');

    await tester.tap(find.byKey(const Key('category.5')));
    await settle(tester);
    expect(queriesOf(api, '/lists/search').last, {
      'keyword': '맛집',
      'sort': 'related',
      'categoryCode': '5',
      'size': '6',
    });

    await tester.tap(find.byKey(const Key('search.sort')));
    await settle(tester);
    await tester.tap(find.text('콜렉트순').last);
    await settle(tester);
    expect(queriesOf(api, '/lists/search').last['sort'], 'collect');
  });
}
