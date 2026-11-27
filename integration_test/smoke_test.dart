// PLAN M5 스모크: 로컬 로그인 → 리스트 생성 → 상세 → 댓글 → 콜렉트 → 로그아웃.
//
// 실제 dev 백엔드에 요청을 보낸다. 기기(시뮬레이터/에뮬레이터)와 백엔드가 필요해 CI 에서는
// 돌리지 않는다. 실행 방법은 README.md 의 "통합 스모크 테스트".
//
//   flutter test integration_test/smoke_test.dart --flavor dev \
//     --dart-define-from-file=env/dev.json -d <device id>
//
// env/dev.json 에 API_BASE_URL (기기에서 닿는 주소), LOCAL_LOGIN_ID, LOCAL_PASSWORD 가 있어야
// 한다. 콜렉트할 다른 사람의 리스트는 최신 피드에서 고른다. 고정하려면
// `--dart-define=SMOKE_COLLECT_LIST_ID=<id>` 를 더한다.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:listywave_app/app/app.dart';
import 'package:listywave_app/app/env.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/bootstrap.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/current_user.dart';
import 'package:listywave_app/features/home/data/home_api.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/list_detail/application/list_detail_providers.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/list_editor/presentation/list_create_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _collectListIdOverride = String.fromEnvironment('SMOKE_COLLECT_LIST_ID');

/// 실제 네트워크라 pumpAndSettle 대신 (skeleton shimmer 처럼 끝나지 않는 animation 이 있다)
/// [finder] 가 보일 때까지 frame 을 흘린다.
Future<void> _pumpUntil(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('$timeout 안에 나타나지 않았다: $finder');
}

/// [condition] 이 참이 될 때까지 frame 을 흘린다.
Future<void> _pumpUntilTrue(
  WidgetTester tester,
  bool Function() condition,
  String description, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (condition()) return;
  }
  fail('$timeout 안에 $description 이(가) 되지 않았다');
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await _pumpUntil(tester, finder);
  await tester.ensureVisible(finder.first);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.tap(finder.first);
  await tester.pump(const Duration(milliseconds: 300));
}

Future<void> _enter(WidgetTester tester, Finder finder, String text) async {
  await _pumpUntil(tester, finder);
  await tester.ensureVisible(finder);
  await tester.enterText(finder, text);
  await tester.pump(const Duration(milliseconds: 100));
}

Finder _keyPrefix(String prefix) => find.byWidgetPredicate(
  (w) =>
      w.key is ValueKey<String> &&
      (w.key! as ValueKey<String>).value.startsWith(prefix),
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('로그인 → 리스트 생성 → 상세 → 댓글 → 콜렉트 → 로그아웃', (tester) async {
    final env = Env.fromEnvironment(Flavor.dev);
    expect(
      env.apiBaseUrl,
      isNotEmpty,
      reason: '--dart-define-from-file=env/dev.json 으로 실행한다',
    );
    expect(
      env.localLoginId,
      isNotEmpty,
      reason: 'env/dev.json 에 LOCAL_LOGIN_ID/LOCAL_PASSWORD 를 넣는다',
    );

    // 이전 실행의 세션이 남아 있으면 로그인 단계를 거치지 않으므로 지운다.
    await const FlutterSecureStorage().deleteAll();
    await (await SharedPreferences.getInstance()).clear();

    await bootstrap(env);
    await _pumpUntil(tester, find.byType(HomeScreen));
    final container = ProviderScope.containerOf(
      tester.element(find.byType(ListyWaveApp)),
    );
    final router = container.read(routerProvider);
    await _pumpUntilTrue(
      tester,
      () =>
          container.read(authControllerProvider).status == AuthStatus.loggedOut,
      '세션 확인 끝 (로그아웃 상태)',
    );

    // 1. 로그인: 하단 "추가" 는 보호 경로라 로그인 sheet 가 뜬다. 로그인하면 만들기 화면으로 간다.
    await _tap(tester, find.byKey(const Key('bottomNav.add')));
    await _tap(tester, find.byKey(const Key('login.local')));
    await _pumpUntilTrue(
      tester,
      () =>
          container.read(authControllerProvider).status == AuthStatus.loggedIn,
      '로그인',
    );
    expect(
      router.state.uri.path,
      isNot('/start-listy'),
      reason: '처음 로그인하는 계정이면 온보딩으로 간다. 온보딩을 마친 계정을 쓴다',
    );
    await _pumpUntil(tester, find.byType(ListCreateScreen));
    final myId = container.read(currentUserIdProvider);
    expect(myId, isNotNull);

    // 2. 리스트 생성: 1단계 (제목, 카테고리) → 2단계 (아이템 3개) → 3단계 게시.
    final stamp = DateTime.now().millisecondsSinceEpoch;
    await _enter(
      tester,
      find.byKey(const Key('editor.title')),
      '스모크 테스트 $stamp',
    );
    await _tap(tester, _keyPrefix('editor.category.'));
    await _tap(tester, find.byKey(const Key('editor.next')));
    for (var i = 0; i < 3; i++) {
      await _enter(
        tester,
        find.byKey(Key('editor.item.$i.title')),
        '아이템 ${i + 1} $stamp',
      );
    }
    await _tap(tester, find.byKey(const Key('editor.next')));
    await _tap(tester, find.byKey(const Key('editor.next')));

    // 3. 상세: 게시하면 만든 리스트의 상세로 간다.
    await _pumpUntil(tester, find.text('스모크 테스트 $stamp'));
    final created = tester.widget<ListDetailScreen>(
      find.byType(ListDetailScreen),
    );
    expect(int.tryParse(created.listId), isNotNull);

    // 4. 댓글.
    await _tap(tester, find.byKey(const Key('listDetail.comments')));
    await _enter(
      tester,
      find.byKey(const Key('comments.input')),
      '스모크 댓글 $stamp',
    );
    await _tap(tester, find.byKey(const Key('comments.send')));
    await _pumpUntil(tester, find.text('스모크 댓글 $stamp'));
    // 댓글 sheet 를 닫는다 (위쪽 barrier).
    await tester.tapAt(const Offset(20, 80));
    await tester.pump(const Duration(seconds: 1));

    // 5. 콜렉트: 내 리스트는 콜렉트할 수 없으므로 다른 사람의 리스트를 연다.
    final collectListId = _collectListIdOverride.isNotEmpty
        ? int.parse(_collectListIdOverride)
        : (await container
                  .read(homeApiProvider)
                  .getRecentLists(category: 'entire'))
              .lists
              .where((l) => l.ownerId != myId)
              .map((l) => l.id)
              .firstOrNull;
    expect(
      collectListId,
      isNotNull,
      reason: 'dev 서버에 다른 사람의 공개 리스트가 필요하다 (SMOKE_COLLECT_LIST_ID)',
    );
    unawaited(router.push(AppRoutes.listDetail('$collectListId')));
    bool? isCollected() =>
        container.read(listDetailProvider(collectListId!)).value?.isCollected;
    await _pumpUntilTrue(tester, () => isCollected() != null, '리스트 조회');
    if (isCollected()!) {
      // 이전 실행에서 콜렉트했으면 먼저 취소한다.
      await _tap(tester, find.byKey(const Key('listFooter.collect')));
      await _pumpUntilTrue(tester, () => isCollected() == false, '콜렉트 취소');
    }
    await _tap(tester, find.byKey(const Key('listFooter.collect')));
    await _pumpUntilTrue(
      tester,
      () =>
          find.byKey(const Key('collect.noFolder')).evaluate().isNotEmpty ||
          _keyPrefix('collect.folder.').evaluate().isNotEmpty,
      '폴더 목록',
    );
    if (find.byKey(const Key('collect.noFolder')).evaluate().isNotEmpty) {
      await _tap(tester, find.byKey(const Key('collect.addFolder')));
      await _enter(
        tester,
        find.byKey(const Key('collect.folderName')),
        '스모크 폴더',
      );
      await _tap(tester, find.byKey(const Key('collect.createFolder')));
      await _pumpUntil(tester, _keyPrefix('collect.folder.'));
    }
    await _tap(tester, _keyPrefix('collect.folder.'));
    await _tap(tester, find.byKey(const Key('collect.confirm')));
    await _pumpUntilTrue(tester, () => isCollected() == true, '콜렉트');

    // 6. 로그아웃: 확인하면 로그아웃 상태로 홈에 간다.
    router.go(AppRoutes.account);
    await _tap(tester, find.byKey(const Key('account.logout')));
    await _tap(tester, find.byKey(const Key('confirmDialog.confirm')));
    await _pumpUntilTrue(
      tester,
      () =>
          container.read(authControllerProvider).status == AuthStatus.loggedOut,
      '로그아웃',
    );
    await _pumpUntil(tester, find.byType(HomeScreen));
    expect(
      GoRouter.of(tester.element(find.byType(HomeScreen))).state.uri.path,
      '/',
    );
  });
}
