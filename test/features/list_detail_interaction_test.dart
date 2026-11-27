import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/core/models/list_type.dart';
import 'package:listywave_app/core/models/reaction_type.dart';
import 'package:listywave_app/core/share/share_service.dart';
import 'package:listywave_app/features/list_detail/application/list_detail_providers.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

/// 리스트 7 (주인 3) 의 상세를 연다. [userId] 가 null 이면 비로그인이다.
Future<(ProviderContainer, ApiMock)> _openDetail(
  WidgetTester tester, {
  int? userId = 9,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
  void Function(ApiMock api)? onMock,
}) async {
  final (container, api) = await pumpWithApi(
    tester,
    userId: userId,
    prefs: prefs,
    overrides: overrides,
    onMock: onMock,
  );
  container.read(routerProvider).push(AppRoutes.listDetail('7'));
  await settle(tester);
  return (container, api);
}

bool? _reacted(ProviderContainer c, ReactionType type) => c
    .read(listDetailProvider(7))
    .value
    ?.reactions
    .firstWhere((r) => r.reaction == type)
    .isReacted;

Map<String, dynamic> _detailWith(Map<String, Object?> changes) => {
  ...fixtureMap('list_detail'),
  ...changes,
};

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

void main() {
  group('리액션', () {
    testWidgets('누르면 POST /lists/{id}/reaction {reaction} 을 보내고 바로 반영한다', (
      tester,
    ) async {
      final (container, api) = await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/lists/7/reaction',
          (s) => s.reply(204, null),
          data: Matchers.any,
        ),
      );
      expect(_reacted(container, ReactionType.cool), isFalse);

      await _tapVisible(tester, find.byKey(const Key('reaction.cool')));
      await tester.pump();
      expect(_reacted(container, ReactionType.cool), isTrue);
      await settle(tester);

      final sent = api.sent('POST', '/lists/7/reaction');
      expect(sent, hasLength(1));
      expect(sent.single.data, {'reaction': 'COOL'});
      // 성공하면 서버 값으로 다시 읽는다.
      expect(api.sent('GET', '/lists/7'), hasLength(2));
    });

    testWidgets('API 가 500 이면 이전 값으로 되돌린다', (tester) async {
      final (container, api) = await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/lists/7/reaction',
          (s) => s.reply(500, serverErrorBody(), delay: serverErrorDelay),
          data: Matchers.any,
        ),
      );
      // fixture 에서 AGREE 는 이미 누른 상태다.
      expect(_reacted(container, ReactionType.agree), isTrue);

      await _tapVisible(tester, find.byKey(const Key('reaction.agree')));
      await tester.pump();
      expect(_reacted(container, ReactionType.agree), isFalse);

      await tester.pump(serverErrorDelay * 2);
      await settle(tester);
      expect(_reacted(container, ReactionType.agree), isTrue);
      expect(api.sent('POST', '/lists/7/reaction').single.data, {
        'reaction': 'AGREE',
      });
      expect(find.text('리액션에 실패했어요. 다시 시도해주세요.'), findsOneWidget);
    });

    test('toggledReactions 는 주인에게 온 count 를 함께 고친다', () {
      final toggled = toggledReactions(const [
        Reaction(reaction: ReactionType.cool, count: 3, isReacted: true),
        Reaction(reaction: ReactionType.agree, count: 0, isReacted: false),
      ], ReactionType.cool);
      expect(toggled.first.isReacted, isFalse);
      expect(toggled.first.count, 2);
      expect(
        toggledReactions(toggled, ReactionType.thanks).last,
        const Reaction(
          reaction: ReactionType.thanks,
          count: null,
          isReacted: true,
        ),
      );
    });
  });

  group('콜렉트', () {
    testWidgets('폴더 sheet 에서 마지막으로 쓴 폴더가 골라져 있고, body 에 folderId 를 보낸다', (
      tester,
    ) async {
      final (container, api) = await _openDetail(
        tester,
        prefs: {'lastCollectFolderId': 2},
        onMock: (api) {
          api.adapter
            ..onGet('/folders', (s) => s.reply(200, fixture('folders')))
            ..onPost(
              '/lists/7/collect',
              (s) => s.reply(204, null),
              data: Matchers.any,
            );
        },
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.collect')));
      await settle(tester);
      expect(api.sent('GET', '/folders'), hasLength(1));
      final group = tester.widget<RadioGroup<int>>(
        find.byType(RadioGroup<int>),
      );
      expect(group.groupValue, 2);

      await tester.tap(find.byKey(const Key('collect.folder.1')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('collect.confirm')));
      await tester.pump();
      expect(container.read(listDetailProvider(7)).value!.isCollected, isTrue);
      await settle(tester);

      expect(api.sent('POST', '/lists/7/collect').single.data, {'folderId': 1});
      expect(find.text('콜렉션에 담았어요.'), findsOneWidget);
      // 다음 콜렉트의 기본 폴더로 기억한다.
      final prefsStore = await SharedPreferences.getInstance();
      expect(prefsStore.getInt('lastCollectFolderId'), 1);
    });

    testWidgets('API 가 500 이면 콜렉트하지 않은 상태로 되돌린다', (tester) async {
      final (container, api) = await _openDetail(
        tester,
        onMock: (api) {
          api.adapter
            ..onGet('/folders', (s) => s.reply(200, fixture('folders')))
            ..onPost(
              '/lists/7/collect',
              (s) => s.reply(500, serverErrorBody(), delay: serverErrorDelay),
              data: Matchers.any,
            );
        },
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.collect')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('collect.confirm')));
      await tester.pump();
      expect(container.read(listDetailProvider(7)).value!.isCollected, isTrue);

      await tester.pump(serverErrorDelay * 2);
      await settle(tester);
      expect(container.read(listDetailProvider(7)).value!.isCollected, isFalse);
      // 저장된 폴더가 없으면 첫 폴더를 고른다.
      expect(api.sent('POST', '/lists/7/collect').single.data, {'folderId': 1});
      expect(find.text('콜렉트에 실패했어요. 다시 시도해주세요.🥲'), findsOneWidget);
    });

    testWidgets('폴더가 없으면 새 폴더를 만들고 (POST /folders) 그 폴더로 콜렉트한다', (
      tester,
    ) async {
      var folders = <Object>[];
      final (_, api) = await _openDetail(
        tester,
        onMock: (api) {
          api.adapter
            ..onGet(
              '/folders',
              (s) => s.replyCallback(200, (_) => {'folders': folders}),
            )
            // handler 는 등록할 때 불리므로 응답을 만들 때 폴더를 추가한다.
            ..onPost(
              '/folders',
              (s) => s.replyCallback(201, (_) {
                folders = [
                  {'folderId': 30, 'folderName': '기본 폴더', 'listCount': 0},
                ];
                return {'folderId': 30};
              }),
              data: Matchers.any,
            )
            ..onPost(
              '/lists/7/collect',
              (s) => s.reply(204, null),
              data: Matchers.any,
            );
        },
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.collect')));
      await settle(tester);
      expect(find.byKey(const Key('collect.noFolder')), findsOneWidget);
      final confirm = tester.widget<FilledButton>(
        find.byKey(const Key('collect.confirm')),
      );
      expect(confirm.onPressed, isNull);

      await tester.tap(find.byKey(const Key('collect.addFolder')));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('collect.folderName')),
        '기본 폴더',
      );
      await tester.tap(find.byKey(const Key('collect.createFolder')));
      await settle(tester);

      expect(api.sent('POST', '/folders').single.data, {'folderName': '기본 폴더'});
      await tester.tap(find.byKey(const Key('collect.confirm')));
      await settle(tester);
      expect(api.sent('POST', '/lists/7/collect').single.data, {
        'folderId': 30,
      });
    });

    testWidgets('이미 콜렉트했으면 sheet 없이 내 폴더 id 로 취소한다', (tester) async {
      final (container, api) = await _openDetail(
        tester,
        prefs: {'lastCollectFolderId': 2},
        onMock: (api) {
          api.adapter
            ..onGet(
              '/lists/7',
              (s) => s.reply(200, _detailWith({'isCollected': true})),
            )
            ..onGet('/folders', (s) => s.reply(200, fixture('folders')))
            ..onPost(
              '/lists/7/collect',
              (s) => s.reply(204, null),
              data: Matchers.any,
            );
        },
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.collect')));
      await tester.pump();
      expect(container.read(listDetailProvider(7)).value!.isCollected, isFalse);
      await settle(tester);

      expect(find.byKey(const Key('collect.confirm')), findsNothing);
      // backend 는 취소에도 folderId 를 요구한다 (CollectionService.collectOrCancel).
      expect(api.sent('POST', '/lists/7/collect').single.data, {'folderId': 2});
      expect(find.text('콜렉트를 취소했어요.'), findsOneWidget);
    });
  });

  group('비로그인', () {
    testWidgets('리액션/콜렉트/팔로우/댓글 입력을 누르면 로그인 sheet 를 띄우고 요청하지 않는다', (
      tester,
    ) async {
      final (_, api) = await _openDetail(tester, userId: null);

      Future<void> expectLoginSheet(Finder target) async {
        await _tapVisible(tester, target);
        await settle(tester);
        expect(find.byType(LoginSheet), findsOneWidget);
        Navigator.of(tester.element(find.byType(LoginSheet))).pop();
        await settle(tester);
        expect(find.byType(LoginSheet), findsNothing);
      }

      await expectLoginSheet(find.byKey(const Key('reaction.cool')));
      await expectLoginSheet(find.byKey(const Key('listFooter.collect')));
      await expectLoginSheet(find.byKey(const Key('follow.3')));

      await _tapVisible(tester, find.byKey(const Key('listDetail.comments')));
      await settle(tester);
      await expectLoginSheet(find.byKey(const Key('comments.input')));

      expect(writesOf(api), isEmpty);
      expect(api.sent('GET', '/folders'), isEmpty);
    });
  });

  group('공유', () {
    testWidgets('공개 리스트는 링크 복사, 카카오톡, OS 공유가 있고 SITE_URL/list/{id} 를 쓴다', (
      tester,
    ) async {
      final share = FakeShareService();
      await _openDetail(
        tester,
        overrides: [shareServiceProvider.overrideWithValue(share)],
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.share')));
      await settle(tester);
      expect(find.byKey(const Key('share.copyLink')), findsOneWidget);
      expect(find.byKey(const Key('share.kakao')), findsOneWidget);
      expect(find.byKey(const Key('share.os')), findsOneWidget);

      await tester.tap(find.byKey(const Key('share.copyLink')));
      await settle(tester);
      expect(share.copied, ['http://localhost:3000/list/7']);
      expect(find.text('링크를 복사했어요. 붙여넣기 해주세요.'), findsOneWidget);

      await _tapVisible(tester, find.byKey(const Key('listFooter.share')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('share.kakao')));
      await settle(tester);
      // web kakaotalkShare.ts 와 같은 template 인자 (주인은 협업자에서 한 번만).
      expect(share.kakaoArgs.single, {
        'title': '서울 브런치 카페 TOP5',
        'description': '주말마다 다니며 고른 브런치 맛집',
        'listId': '7',
        'itemTitle1': '카페 어니언 성수',
        'itemTitle2': '테일러커피',
        'itemTitle3': '빌즈 광화문',
        'allWriter': '서핑하는개발자,영화광,빵지순례',
      });

      await _tapVisible(tester, find.byKey(const Key('listFooter.share')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('share.os')));
      await settle(tester);
      expect(share.shared, ['http://localhost:3000/list/7']);
    });

    testWidgets('비공개 리스트의 공유 sheet 에는 카카오톡 항목이 없다', (tester) async {
      await _openDetail(
        tester,
        // 비공개 리스트는 주인(3)만 볼 수 있다.
        userId: 3,
        overrides: [shareServiceProvider.overrideWithValue(FakeShareService())],
        onMock: (api) => api.adapter.onGet(
          '/lists/7',
          (s) => s.reply(200, _detailWith({'isPublic': false})),
        ),
      );

      await _tapVisible(tester, find.byKey(const Key('listFooter.share')));
      await settle(tester);
      expect(find.byKey(const Key('share.copyLink')), findsOneWidget);
      expect(find.byKey(const Key('share.os')), findsOneWidget);
      expect(find.byKey(const Key('share.kakao')), findsNothing);
    });

    testWidgets('이미지로 저장은 카드를 PNG 로 만들어 갤러리에 저장하고, 권한 거절을 안내한다', (
      tester,
    ) async {
      final share = FakeShareService();
      await _openDetail(
        tester,
        overrides: [shareServiceProvider.overrideWithValue(share)],
      );

      Future<void> save() async {
        await _tapVisible(tester, find.byKey(const Key('listFooter.more')));
        await settle(tester);
        await tester.tap(find.byKey(const Key('etc.saveImage')));
        await settle(tester);
        // web 저장 이미지처럼 폭 390 캡처에 로고 옆 작성자·저장 날짜와 사이트 주소가 있다.
        expect(
          tester.getSize(find.byKey(const Key('saveImage.capture'))).width,
          390,
        );
        expect(find.textContaining('님의 리스트 · '), findsOneWidget);
        final attempts = share.saveAttempts;
        await tester.runAsync(() async {
          await tester.tap(find.byKey(const Key('saveImage.save')));
          // 사진 precache 와 RepaintBoundary.toImage 는 실제 비동기 작업이다. 저장 호출이 올 때까지
          // 기다린다 (최대 10초).
          for (var i = 0; i < 200 && share.saveAttempts == attempts; i++) {
            await Future<void>.delayed(const Duration(milliseconds: 50));
          }
        });
        expect(share.saveAttempts, attempts + 1);
        await settle(tester);
      }

      await save();
      expect(share.savedImages, hasLength(1));
      expect(find.text('리스트 이미지를 갤러리에 저장했어요.'), findsOneWidget);
      // 안내가 사라질 때까지 기다린다 (다음 저장이 이전 SnackBar 를 닫지 않게).
      await tester.pump(const Duration(seconds: 5));
      await settle(tester);

      share.saveError = const SaveImageException(SaveImageFailure.accessDenied);
      await save();
      expect(share.savedImages, hasLength(1));
      expect(find.text('사진 보관함 접근 권한이 필요해요. 설정에서 허용해 주세요.'), findsOneWidget);
    });
  });

  group('주인 메뉴', () {
    testWidgets('공개/비공개 전환은 PATCH /lists/{id}/visibility 를 보내고 바로 반영한다', (
      tester,
    ) async {
      final (container, api) = await _openDetail(
        tester,
        userId: 3,
        onMock: (api) => api.adapter.onPatch(
          '/lists/7/visibility',
          (s) => s.reply(204, null),
        ),
      );

      await tester.tap(find.byKey(const Key('listDetail.ownerMenu')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('owner.visibility')));
      await tester.pump();
      expect(container.read(listDetailProvider(7)).value!.isPublic, isFalse);
      await settle(tester);

      expect(api.sent('PATCH', '/lists/7/visibility'), hasLength(1));
      expect(find.text('리스트 공개/비공개 변경을 완료했어요.'), findsOneWidget);
    });

    testWidgets('삭제는 확인 뒤 DELETE /lists/{id} 를 보내고 내 마이리스트로 간다', (
      tester,
    ) async {
      final (container, api) = await _openDetail(
        tester,
        userId: 3,
        onMock: (api) =>
            api.adapter.onDelete('/lists/7', (s) => s.reply(204, null)),
      );

      await tester.tap(find.byKey(const Key('listDetail.ownerMenu')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('owner.delete')));
      await settle(tester);
      // 취소하면 보내지 않는다.
      await tester.tap(find.byKey(const Key('confirmDialog.cancel')));
      await settle(tester);
      expect(api.sent('DELETE', '/lists/7'), isEmpty);

      await tester.tap(find.byKey(const Key('listDetail.ownerMenu')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('owner.delete')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('confirmDialog.confirm')));
      await settle(tester);

      expect(api.sent('DELETE', '/lists/7'), hasLength(1));
      expect(find.byType(UserProfileScreen), findsOneWidget);
      expect(
        container.read(routerProvider).state.uri.path,
        AppRoutes.myList('3'),
      );
    });
  });

  group('댓글', () {
    Future<ApiMock> openComments(WidgetTester tester, {int userId = 9}) async {
      final (_, api) = await _openDetail(
        tester,
        userId: userId,
        onMock: (api) {
          api.adapter
            ..onPost(
              '/lists/7/comments',
              (s) => s.reply(201, {'id': 40}),
              data: Matchers.any,
            )
            ..onPost(
              '/lists/7/comments/33/replies',
              (s) => s.reply(201, {'id': 72}),
              data: Matchers.any,
            )
            ..onPatch(
              '/lists/7/comments/33',
              (s) => s.reply(204, null),
              data: Matchers.any,
            )
            ..onDelete('/lists/7/comments/33', (s) => s.reply(204, null));
        },
      );
      await _tapVisible(tester, find.byKey(const Key('listDetail.comments')));
      await settle(tester);
      return api;
    }

    testWidgets('작성에 성공하면 댓글 목록을 다시 부른다 (요청 2회)', (tester) async {
      final api = await openComments(tester);
      expect(api.sent('GET', '/lists/7/comments'), hasLength(1));

      await tester.enterText(
        find.byKey(const Key('comments.input')),
        '저도 가볼게요',
      );
      await tester.pump();
      await tester.tap(find.byKey(const Key('comments.send')));
      await settle(tester);

      expect(api.sent('POST', '/lists/7/comments').single.data, {
        'content': '저도 가볼게요',
        'mentionIds': <int>[],
      });
      expect(api.sent('GET', '/lists/7/comments'), hasLength(2));
      // 댓글 수/최신 댓글이 바뀌므로 상세도 다시 읽는다.
      expect(api.sent('GET', '/lists/7'), hasLength(2));
      final input = tester.widget<TextField>(
        find.byKey(const Key('comments.input')),
      );
      expect(input.controller!.text, isEmpty);
    });

    testWidgets('답글의 답글은 그 작성자를 멘션한다 (mentionIds)', (tester) async {
      final api = await openComments(tester);

      await _tapVisible(
        tester,
        find.byKey(const Key('comment.33.showReplies')),
      );
      await settle(tester);
      await _tapVisible(tester, find.byKey(const Key('reply.71.reply')));
      await settle(tester);
      expect(find.text('@서핑하는개발자 님에게 남긴 답글'), findsOneWidget);
      final input = tester.widget<TextField>(
        find.byKey(const Key('comments.input')),
      );
      expect(input.controller!.text, '@서핑하는개발자 ');

      await tester.enterText(
        find.byKey(const Key('comments.input')),
        '@서핑하는개발자 고마워요',
      );
      await tester.pump();
      await tester.tap(find.byKey(const Key('comments.send')));
      await settle(tester);

      expect(api.sent('POST', '/lists/7/comments/33/replies').single.data, {
        'content': '@서핑하는개발자 고마워요',
        'mentionIds': [3],
      });
      expect(api.sent('GET', '/lists/7/comments'), hasLength(2));
    });

    testWidgets('내 댓글은 수정(PATCH)·삭제(DELETE)할 수 있고, 남의 댓글에는 버튼이 없다', (
      tester,
    ) async {
      // 댓글 33 의 작성자(8)로 로그인한다.
      final api = await openComments(tester, userId: 8);
      expect(find.byKey(const Key('comment.31.edit')), findsNothing);

      await _tapVisible(tester, find.byKey(const Key('comment.33.edit')));
      await settle(tester);
      expect(find.text('댓글/답글 수정 중'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('comments.input')), '수정했어요');
      await tester.pump();
      await tester.tap(find.byKey(const Key('comments.send')));
      await settle(tester);
      expect(api.sent('PATCH', '/lists/7/comments/33').single.data, {
        'content': '수정했어요',
        'mentionIds': <int>[],
      });

      await _tapVisible(tester, find.byKey(const Key('comment.33.delete')));
      await settle(tester);
      await tester.tap(find.byKey(const Key('confirmDialog.confirm')));
      await settle(tester);
      expect(api.sent('DELETE', '/lists/7/comments/33'), hasLength(1));
      // 수정·삭제마다 다시 읽는다.
      expect(api.sent('GET', '/lists/7/comments'), hasLength(3));
    });
  });
}
