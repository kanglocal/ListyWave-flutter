import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/upload/image_compressor.dart';
import 'package:listywave_app/core/upload/image_source.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/list_editor/presentation/list_create_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';
import '../helpers/write_api_mocks.dart';

const _mb = 1024 * 1024;
const _url1 =
    'https://bucket.r2.example.com/dev/lists_item/7/a.jpeg?X-Amz-Signature=1';
const _url3 =
    'https://bucket.r2.example.com/dev/lists_item/7/b.png?X-Amz-Signature=3';

/// 결과 크기가 `width * height * quality / 50` byte 인 가짜 인코더. 원본은 4000x3000 이다.
class _FakeCodec implements ImageCodec {
  final calls = <({int width, int height, int quality})>[];

  @override
  Future<({int width, int height})> sizeOf(Uint8List bytes) async =>
      (width: 4000, height: 3000);

  @override
  Future<Uint8List> encodeJpeg(
    Uint8List bytes, {
    required int width,
    required int height,
    required int quality,
  }) async {
    calls.add((width: width, height: height, quality: quality));
    return Uint8List(width * height * quality ~/ 50);
  }
}

/// 고를 때마다 [images] 를 앞에서부터 하나씩 돌려준다.
PickImage _picker(List<PickedImage> images) {
  final queue = [...images];
  return () async => queue.isEmpty ? null : queue.removeAt(0);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _enter(WidgetTester tester, Finder finder, String text) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, text);
  await tester.pump();
}

Key _k(String value) => Key(value);

/// 맨 위 화면의 location (push 한 화면 포함).
String _top(GoRouter router) => router.state.uri.toString();

/// 1단계(제목, 카테고리) → 2단계(아이템 3개, [images] 의 rank 에 이미지) → 3단계 게시.
Future<void> _fillAndPublish(
  WidgetTester tester, {
  Set<int> imageRanks = const {},
}) async {
  await _enter(tester, find.byKey(_k('editor.title')), '내 최애 앨범');
  await _tap(tester, find.byKey(_k('editor.category.music')));
  await _tap(tester, find.byKey(_k('editor.next')));

  for (var i = 0; i < 3; i++) {
    await _enter(tester, find.byKey(_k('editor.item.$i.title')), '앨범 ${i + 1}');
  }
  for (final rank in imageRanks) {
    final i = rank - 1;
    await _tap(tester, find.byKey(_k('editor.item.$i.expand')));
    await _tap(tester, find.byKey(_k('editor.item.$i.image')));
    expect(find.byKey(_k('editor.item.$i.imagePreview')), findsOneWidget);
  }
  await _tap(tester, find.byKey(_k('editor.next')));
  await _tap(tester, find.byKey(_k('editor.next')));
  await settle(tester);
}

void _mockCreate(ApiMock api) {
  api.adapter
    ..onPost('/lists', (s) => s.reply(201, {'listId': 7}), data: Matchers.any)
    ..onPost(
      '/lists/upload-url',
      (s) => s.reply(200, [
        {'rank': 1, 'presignedUrl': _url1},
        {'rank': 3, 'presignedUrl': _url3},
      ]),
      data: Matchers.any,
    )
    ..onPut(_url1, (s) => s.reply(200, null), data: Matchers.any)
    ..onPut(_url3, (s) => s.reply(200, null), data: Matchers.any)
    ..onPost(
      '/lists/upload-complete',
      (s) => s.reply(204, null),
      data: Matchers.any,
    );
}

void main() {
  group('리스트 생성', () {
    testWidgets(
      '이미지가 있으면 POST /lists → upload-url → presigned PUT ×N → upload-complete 순서로 보낸다',
      (tester) async {
        final codec = _FakeCodec();
        final (container, api) = await pumpWithApi(
          tester,
          userId: 9,
          overrides: [
            imageCompressorProvider.overrideWithValue(ImageCompressor(codec)),
            pickImageProvider.overrideWithValue(
              _picker([
                // 4MB 를 넘는 JPEG 는 압축된다.
                PickedImage(
                  bytes: Uint8List(6 * _mb),
                  mimeType: 'image/jpeg',
                  name: 'big.jpg',
                ),
                PickedImage(
                  bytes: Uint8List(1000),
                  mimeType: 'image/png',
                  name: 'small.png',
                ),
              ]),
            ),
          ],
          onMock: _mockCreate,
        );
        final router = container.read(routerProvider);
        router.go(AppRoutes.listCreate);
        await settle(tester);

        await _fillAndPublish(tester, imageRanks: {1, 3});

        expect(writesOf(api), [
          'POST /lists',
          'POST /lists/upload-url',
          'PUT ${Uri.parse(_url1).path}',
          'PUT ${Uri.parse(_url3).path}',
          'POST /lists/upload-complete',
        ]);

        final create = api.sent('POST', '/lists').single.data as Map;
        expect(create['category'], 'music');
        expect(create['title'], '내 최애 앨범');
        expect(create['isPublic'], true);
        expect(create['backgroundPalette'], 'PASTEL');
        expect(create['backgroundColor'], 'PASTEL_PINK');
        expect(create['labels'], <String>[]);
        expect(create['collaboratorIds'], <int>[]);
        expect(create['items'], [
          for (var rank = 1; rank <= 3; rank++)
            {
              'rank': rank,
              'title': '앨범 $rank',
              'comment': '',
              'link': '',
              // 새 이미지 자리는 비워 두고 upload-complete 가 채운다.
              'imageUrl': '',
            },
        ]);

        final images = {
          'listId': 7,
          'extensionRanks': [
            {'rank': 1, 'extension': 'jpeg'},
            {'rank': 3, 'extension': 'png'},
          ],
        };
        expect(api.sent('POST', '/lists/upload-url').single.data, images);
        expect(api.sent('POST', '/lists/upload-complete').single.data, images);

        final big = api.sent('PUT', Uri.parse(_url1).path).single;
        final small = api.sent('PUT', Uri.parse(_url3).path).single;
        // presigned PUT 은 백엔드 토큰을 붙이지 않고 파일 MIME 을 그대로 보낸다.
        expect(authorizationOf(big), isNull);
        expect(authorizationOf(small), isNull);
        expect(big.headers[Headers.contentTypeHeader], 'image/jpeg');
        expect(small.headers[Headers.contentTypeHeader], 'image/png');
        // 6MB 원본은 긴 변 1920 이하, 4MB 이하로 줄었다.
        expect(
          (big.data as Uint8List).length,
          lessThanOrEqualTo(ImageCompressor.maxBytes),
        );
        expect(codec.calls, isNotEmpty);
        expect(
          codec.calls.every((c) => c.width <= 1920 && c.height <= 1920),
          isTrue,
        );
        // 4MB 이하 PNG 는 그대로 올린다.
        expect((small.data as Uint8List).length, 1000);

        // 하단 탭으로 들어왔으므로 홈 위에 상세를 열어, 뒤로 가면 홈이다.
        expect(_top(router), '/list/7');
        expect(find.byType(ListDetailScreen), findsOneWidget);
        router.pop();
        await settle(tester);
        expect(_top(router), '/');
      },
    );

    testWidgets('이미지가 없으면 upload-url 과 upload-complete 를 부르지 않는다', (
      tester,
    ) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockCreate,
      );
      final router = container.read(routerProvider);
      router.push(AppRoutes.listCreate);
      await settle(tester);

      await _fillAndPublish(tester);

      expect(writesOf(api), ['POST /lists']);
      expect(_top(router), '/list/7');
    });

    testWidgets('?title=&category=(한글 이름) 로 1단계를 채운다', (tester) async {
      final (container, _) = await pumpWithApi(tester, userId: 9);
      container
          .read(routerProvider)
          .push(
            Uri(
              path: AppRoutes.listCreate,
              queryParameters: {'title': '비 오는 날 노래', 'category': '음악'},
            ).toString(),
          );
      await settle(tester);

      expect(find.byType(ListCreateScreen), findsOneWidget);
      final title = tester.widget<TextField>(find.byKey(_k('editor.title')));
      expect(title.controller!.text, '비 오는 날 노래');
      final music = tester.widget<ChoiceChip>(
        find.byKey(_k('editor.category.music')),
      );
      expect(music.selected, isTrue);
      final next = tester.widget<TextButton>(find.byKey(_k('editor.next')));
      expect(next.onPressed, isNotNull);
    });

    testWidgets('아이템이 3개보다 적으면 다음으로 갈 수 없고 같은 이름이면 막는다', (tester) async {
      final (container, api) = await pumpWithApi(tester, userId: 9);
      container.read(routerProvider).push(AppRoutes.listCreate);
      await settle(tester);
      await _enter(tester, find.byKey(_k('editor.title')), '제목');
      await _tap(tester, find.byKey(_k('editor.category.music')));
      await _tap(tester, find.byKey(_k('editor.next')));

      await _tap(tester, find.byKey(_k('editor.item.2.expand')));
      await _tap(tester, find.byKey(_k('editor.item.2.delete')));
      expect(find.byKey(_k('editor.minItemWarning')), findsOneWidget);
      await _enter(tester, find.byKey(_k('editor.item.0.title')), '같은 이름');
      await _enter(tester, find.byKey(_k('editor.item.1.title')), '같은 이름');
      var next = tester.widget<TextButton>(find.byKey(_k('editor.next')));
      expect(next.onPressed, isNull);

      await _tap(tester, find.byKey(_k('editor.addItem')));
      await _enter(tester, find.byKey(_k('editor.item.2.title')), '다른 이름');
      next = tester.widget<TextButton>(find.byKey(_k('editor.next')));
      expect(next.onPressed, isNotNull);
      await _tap(tester, find.byKey(_k('editor.next')));

      // 중복 toast 를 띄우고 2단계에 남는다.
      expect(find.byKey(_k('editor.item.0.title')), findsOneWidget);
      expect(writesOf(api), isEmpty);
    });

    testWidgets('3단계: 라벨, 협업자, 배경, 공개 여부를 body 에 담는다', (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockCreate,
      );
      container.read(routerProvider).push(AppRoutes.listCreate);
      await settle(tester);
      await _enter(tester, find.byKey(_k('editor.title')), '제목');
      await _tap(tester, find.byKey(_k('editor.category.music')));
      await _tap(tester, find.byKey(_k('editor.next')));
      for (var i = 0; i < 3; i++) {
        await _enter(tester, find.byKey(_k('editor.item.$i.title')), '아이템$i');
      }
      // 순서를 바꾸면 rank 가 바뀐다 (첫 아이템을 맨 아래로).
      await tester.drag(
        find.byIcon(Icons.drag_indicator).first,
        const Offset(0, 300),
      );
      await tester.pumpAndSettle();
      await _tap(tester, find.byKey(_k('editor.next')));

      final labelInput = find.byKey(_k('editor.labelInput'));
      await _enter(tester, labelInput, '성수 ');
      await _enter(tester, labelInput, '브런치,');
      await _enter(tester, labelInput, '특수!');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(find.text('유효한 한글, 영어, 숫자만 입력해 주세요.'), findsOneWidget);

      await _enter(tester, find.byKey(_k('editor.collaboratorSearch')), '빵');
      await tester.pump(const Duration(milliseconds: 350));
      await settle(tester);
      await _tap(tester, find.byKey(_k('editor.collaboratorResult.8')));
      expect(find.byKey(_k('editor.collaborator.8')), findsOneWidget);

      await _tap(tester, find.byKey(_k('editor.palette.neon')));
      await _tap(tester, find.byKey(_k('editor.color.NEON_BLUE')));
      await _tap(tester, find.byKey(_k('editor.private')));
      await _tap(tester, find.byKey(_k('editor.next')));
      await settle(tester);

      expect(queriesOf(api, '/users').last, {'search': '빵', 'size': '3'});
      final body = api.sent('POST', '/lists').single.data as Map;
      expect(body['labels'], ['성수', '브런치']);
      expect(body['collaboratorIds'], [8]);
      expect(body['backgroundPalette'], 'NEON');
      expect(body['backgroundColor'], 'NEON_BLUE');
      expect(body['isPublic'], false);
      expect(
        [for (final i in body['items'] as List) (i as Map)['title']],
        ['아이템1', '아이템2', '아이템0'],
      );
      expect(
        [for (final i in body['items'] as List) (i as Map)['rank']],
        [1, 2, 3],
      );
    });
  });

  testWidgets('상세의 "이 주제로 만들기" 는 제목과 카테고리로 만들기 화면을 연다', (tester) async {
    final (container, _) = await pumpWithApi(tester, userId: 9);
    final router = container.read(routerProvider);
    router.push(AppRoutes.listDetail('7'));
    await settle(tester);

    await _tap(tester, find.byKey(_k('listFooter.more')));
    await _tap(tester, find.byKey(_k('etc.createWithTitle')));
    await settle(tester);

    expect(router.state.uri.path, AppRoutes.listCreate);
    final title = tester.widget<TextField>(find.byKey(_k('editor.title')));
    expect(title.controller!.text, '서울 브런치 카페 TOP5');
    final category = tester.widget<ChoiceChip>(
      find.byKey(_k('editor.category.restaurant_cafe')),
    );
    expect(category.selected, isTrue);
    // 닫으면 상세로 돌아간다.
    await _tap(tester, find.byKey(_k('editor.back')));
    expect(_top(router), '/list/7');
  });

  group('리스트 수정', () {
    testWidgets('상세 내용으로 채우고, 기존 이미지는 URL 을 유지해 PATCH 한 뒤 상세를 다시 읽는다', (
      tester,
    ) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 3,
        overrides: [
          pickImageProvider.overrideWithValue(
            _picker([
              PickedImage(
                bytes: Uint8List(500),
                mimeType: 'image/png',
                name: 'new.png',
              ),
            ]),
          ),
        ],
        onMock: (api) => api.adapter
          ..onPatch('/lists/7', (s) => s.reply(204, null), data: Matchers.any)
          ..onPost(
            '/lists/upload-url',
            (s) => s.reply(200, [
              {'rank': 3, 'presignedUrl': _url3},
            ]),
            data: Matchers.any,
          )
          ..onPut(_url3, (s) => s.reply(200, null), data: Matchers.any)
          ..onPost(
            '/lists/upload-complete',
            (s) => s.reply(204, null),
            data: Matchers.any,
          ),
      );
      final router = container.read(routerProvider);
      router.push(AppRoutes.listDetail('7'));
      await settle(tester);
      router.push(AppRoutes.listEdit('7'));
      await settle(tester);
      final detailReads = api.sent('GET', '/lists/7').length;

      final title = tester.widget<TextField>(find.byKey(_k('editor.title')));
      expect(title.controller!.text, '서울 브런치 카페 TOP5');
      await _tap(tester, find.byKey(_k('editor.next')));
      // 이미 있는 아이템의 이름은 고칠 수 없다.
      final item0 = tester.widget<TextField>(
        find.byKey(_k('editor.item.0.title')),
      );
      expect(item0.readOnly, isTrue);
      await _tap(tester, find.byKey(_k('editor.item.2.expand')));
      await _tap(tester, find.byKey(_k('editor.item.2.image')));
      await _tap(tester, find.byKey(_k('editor.next')));
      await _tap(tester, find.byKey(_k('editor.next')));
      await settle(tester);

      expect(writesOf(api), [
        'PATCH /lists/7',
        'POST /lists/upload-url',
        'PUT ${Uri.parse(_url3).path}',
        'POST /lists/upload-complete',
      ]);
      final body = api.sent('PATCH', '/lists/7').single.data as Map;
      expect(body['category'], 'restaurant_cafe');
      expect(body['labels'], ['성수', '브런치']);
      // 주인(3)은 협업자 목록에서 뺀다.
      expect(body['collaboratorIds'], [5, 8]);
      expect(body['backgroundPalette'], 'PASTEL');
      expect(body['backgroundColor'], 'PASTEL_YELLOW');
      expect(body['items'], [
        {
          'rank': 1,
          'title': '카페 어니언 성수',
          'comment': '팡도르가 최고',
          'link': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          'imageUrl': 'https://pub-4f2c1e.r2.dev/lists/101/items/1.jpg',
        },
        {
          'rank': 2,
          'title': '테일러커피',
          'comment': '',
          'link': 'https://blog.example.com/taylor-coffee',
          'imageUrl': '',
        },
        {
          'rank': 3,
          'title': '빌즈 광화문',
          'comment': '',
          'link': '',
          'imageUrl': '',
        },
      ]);
      expect(api.sent('POST', '/lists/upload-url').single.data, {
        'listId': 7,
        'extensionRanks': [
          {'rank': 3, 'extension': 'png'},
        ],
      });
      // 상세로 돌아가고 상세를 다시 읽는다.
      expect(_top(router), '/list/7');
      expect(api.sent('GET', '/lists/7').length, greaterThan(detailReads));
    });

    testWidgets('PATCH 가 실패하면 수정 화면에 남는다', (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 3,
        onMock: (api) => api.adapter.onPatch(
          '/lists/7',
          (s) => s.reply(500, serverErrorBody()),
          data: Matchers.any,
        ),
      );
      final router = container.read(routerProvider);
      router.push(AppRoutes.listEdit('7'));
      await settle(tester);
      await _tap(tester, find.byKey(_k('editor.next')));
      await _tap(tester, find.byKey(_k('editor.next')));
      await _tap(tester, find.byKey(_k('editor.next')));
      await settle(tester);

      expect(writesOf(api), ['PATCH /lists/7']);
      expect(_top(router), '/list/7/edit');
      expect(find.text('리스트 수정에 실패했어요. 다시 시도해주세요.🥲'), findsOneWidget);
    });
  });
}
