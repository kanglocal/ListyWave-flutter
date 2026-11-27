import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/features/collection/presentation/collection_folders_screen.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';
import '../helpers/write_api_mocks.dart';

void _mockFolders(ApiMock api) => api.adapter
  ..onGet('/folders', (s) => s.reply(200, fixture('folders')))
  ..onGet('/folder/1/collections', (s) => s.reply(200, fixture('collections')))
  ..onGet(
    '/folder/0/collections',
    (s) => s.reply(200, {...fixtureMap('collections'), 'folderName': '전체'}),
  )
  ..onPost('/folders', (s) => s.reply(201, {'folderId': 3}), data: Matchers.any)
  ..onPut('/folders/1', (s) => s.reply(204, null), data: Matchers.any)
  ..onDelete('/folders/1', (s) => s.reply(204, null));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('폴더 목록: GET /folders 와 "전체" 폴더를 보이고, 폴더 추가는 POST /folders', (
    tester,
  ) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collection);
    await settle(tester);

    expect(find.byType(CollectionFoldersScreen), findsOneWidget);
    expect(find.byKey(const Key('collection.folder.0')), findsOneWidget);
    expect(find.text('기본 폴더 (3)'), findsOneWidget);
    expect(find.text('가고 싶은 곳'), findsOneWidget);
    final reads = api.sent('GET', '/folders').length;

    await _tap(tester, find.byKey(const Key('collection.addFolder')));
    await tester.enterText(find.byKey(const Key('collect.folderName')), ' 여행 ');
    await _tap(tester, find.byKey(const Key('collect.createFolder')));
    await settle(tester);

    expect(api.sent('POST', '/folders').single.data, {'folderName': '여행'});
    expect(api.sent('GET', '/folders').length, greaterThan(reads));
  });

  testWidgets('빈 폴더 이름은 보내지 않는다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collection);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('collection.addFolder')));
    await tester.enterText(find.byKey(const Key('collect.folderName')), '  ');
    await _tap(tester, find.byKey(const Key('collect.createFolder')));

    expect(find.text('폴더명을 작성해 주세요.'), findsOneWidget);
    expect(writesOf(api), isEmpty);
  });

  testWidgets('폴더 상세: GET /folder/{id}/collections?size=10 를 grid 로 보인다', (
    tester,
  ) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collectionFolder('1'));
    await settle(tester);

    expect(queriesOf(api, '/folder/1/collections').first, {'size': '10'});
    expect(find.text('기본 폴더'), findsOneWidget);
    expect(find.byKey(const Key('collection.list.101')), findsOneWidget);
    expect(find.text('서울 브런치 카페 TOP5'), findsOneWidget);
  });

  testWidgets('"전체" 폴더(0) 는 이름 바꾸기/삭제 메뉴가 없다', (tester) async {
    final (container, _) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collectionFolder('0'));
    await settle(tester);

    expect(find.byKey(const Key('collection.detailMenu')), findsNothing);
    expect(find.byKey(const Key('collection.list.101')), findsOneWidget);
  });

  testWidgets('폴더 이름 바꾸기: PUT /folders/{id} {folderName}', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collectionFolder('1'));
    await settle(tester);

    await _tap(tester, find.byKey(const Key('collection.detailMenu')));
    await _tap(tester, find.byKey(const Key('collection.menu.rename')));
    final field = tester.widget<TextField>(
      find.byKey(const Key('collect.folderName')),
    );
    expect(field.controller!.text, '기본 폴더');
    await tester.enterText(
      find.byKey(const Key('collect.folderName')),
      '최애 폴더',
    );
    await _tap(tester, find.byKey(const Key('collect.createFolder')));
    await settle(tester);

    expect(writesOf(api), ['PUT /folders/1']);
    expect(api.sent('PUT', '/folders/1').single.data, {'folderName': '최애 폴더'});
    // 이름과 목록을 다시 읽는다.
    expect(api.sent('GET', '/folders').length, greaterThanOrEqualTo(2));
    expect(api.sent('GET', '/folder/1/collections').length, 2);
  });

  testWidgets('폴더 삭제: 확인 뒤 DELETE /folders/{id} 하고 폴더 목록으로 돌아간다', (
    tester,
  ) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    final router = container.read(routerProvider);
    router.push(AppRoutes.collection);
    await settle(tester);
    await _tap(tester, find.byKey(const Key('collection.folder.1')));
    await settle(tester);
    expect(router.state.uri.toString(), '/collection/1');

    await _tap(tester, find.byKey(const Key('collection.detailMenu')));
    await _tap(tester, find.byKey(const Key('collection.menu.delete')));
    expect(find.text('정말 삭제하시나요?'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(writesOf(api), ['DELETE /folders/1']);
    expect(router.state.uri.toString(), '/collection');
  });

  testWidgets('폴더 목록의 메뉴로도 이름을 바꾸고 지울 수 있다', (tester) async {
    final (container, api) = await pumpWithApi(
      tester,
      userId: 9,
      onMock: _mockFolders,
    );
    container.read(routerProvider).push(AppRoutes.collection);
    await settle(tester);

    await _tap(tester, find.byKey(const Key('collection.folderMenu.1')));
    await _tap(tester, find.byKey(const Key('collection.menu.rename')));
    await tester.enterText(find.byKey(const Key('collect.folderName')), '새 이름');
    await _tap(tester, find.byKey(const Key('collect.createFolder')));
    await settle(tester);
    await _tap(tester, find.byKey(const Key('collection.folderMenu.1')));
    await _tap(tester, find.byKey(const Key('collection.menu.delete')));
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await settle(tester);

    expect(writesOf(api), ['PUT /folders/1', 'DELETE /folders/1']);
  });
}
