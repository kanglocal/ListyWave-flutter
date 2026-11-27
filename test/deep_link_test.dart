import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/not_found_screen.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/core/share/share_service.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_detail_screen.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';

import 'helpers/pump_app.dart';
import 'helpers/read_api_mocks.dart';

/// 앱이 떠 있을 때 OS 가 deeplink 를 넘기는 것과 같은 platform message
/// (iOS `openURL`/Universal Link, Android `onNewIntent` → `pushRouteInformation`).
Future<void> _openDeepLink(WidgetTester tester, String url) async {
  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    SystemChannels.navigation.name,
    SystemChannels.navigation.codec.encodeMethodCall(
      MethodCall('pushRouteInformation', {'location': url, 'state': null}),
    ),
    (_) {},
  );
  await settle(tester);
}

Future<void> _pumpDeepLinkApp(WidgetTester tester) async {
  await pumpApp(
    tester,
    beforePump: (c) => mockReadApis(ApiMock(c), detailListId: 1),
  );
}

void main() {
  group('deepLinkLocation', () {
    const cases = <String, String?>{
      // 앱 안의 이동은 바꾸지 않는다.
      '/list/1': null,
      // 웹 공유 URL (Universal Links / App Links).
      'https://listywave.vercel.app/list/1': '/list/1',
      'https://listywave.vercel.app/user/1/mylist': '/user/1/mylist',
      'https://listywave.vercel.app/notice/4?ref=share': '/notice/4?ref=share',
      'https://listywave.vercel.app': '/',
      'http://localhost:3000/list/1': '/list/1',
      // custom scheme.
      'listywave://list/1': '/list/1',
      'listywave://user/1/mylist': '/user/1/mylist',
      'listywave://search?keyword=a': '/search?keyword=a',
      'listywave://': '/',
      'listywave://account': '/account',
      'listywave://account/': '/account',
      'listywave://list/1/': '/list/1',
      'LISTYWAVE://list/1': '/list/1',
      // 카카오톡 공유 메시지의 앱 실행 파라미터.
      'kakaoabc123://kakaolink?listId=1': '/list/1',
      'kakaoabc123://kakaolink': '/',
      'kakaoabc123://kakaolink?listId=abc': '/',
      // 모르는 scheme 은 경로로 바꾸지 않는다 (→ not-found).
      'otherapp://list/1': null,
      'kakaoabc123://oauth?code=1': null,
    };
    for (final MapEntry(key: url, value: expected) in cases.entries) {
      test('$url → $expected', () {
        expect(deepLinkLocation(Uri.parse(url)), expected);
      });
    }
  });

  group('platform 이 넘긴 deeplink 로 화면을 연다', () {
    testWidgets('listywave://list/1 → ListDetail(1)', (tester) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'listywave://list/1');

      final screen = tester.widget<ListDetailScreen>(
        find.byType(ListDetailScreen),
      );
      expect(screen.listId, '1');
      expect(find.text('서울 브런치 카페 TOP5'), findsWidgets);
    });

    testWidgets('https://<SITE_HOST>/list/1 → ListDetail(1)', (tester) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'https://listywave.vercel.app/list/1');

      final screen = tester.widget<ListDetailScreen>(
        find.byType(ListDetailScreen),
      );
      expect(screen.listId, '1');
    });

    testWidgets('listywave://user/1/mylist → UserProfile(1, 마이리스트)', (
      tester,
    ) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'listywave://user/1/mylist');

      final screen = tester.widget<UserProfileScreen>(
        find.byType(UserProfileScreen),
      );
      expect((screen.userId, screen.tab), ('1', UserProfileTab.my));
    });

    testWidgets('https://<SITE_HOST>/notice/4 → NoticeDetail(4)', (
      tester,
    ) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'https://listywave.vercel.app/notice/4');

      final screen = tester.widget<NoticeDetailScreen>(
        find.byType(NoticeDetailScreen),
      );
      expect(screen.noticeId, '4');
    });

    testWidgets('kakao{KEY}://kakaolink?listId=1 → ListDetail(1)', (
      tester,
    ) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'kakaoabc123://kakaolink?listId=1');

      final screen = tester.widget<ListDetailScreen>(
        find.byType(ListDetailScreen),
      );
      expect(screen.listId, '1');
    });

    testWidgets('iOS 처럼 카카오 SDK 로만 받은 kakaolink 도 ListDetail(1) 을 연다', (
      tester,
    ) async {
      void Function(Uri)? onKakaoLink;
      await pumpApp(
        tester,
        overrides: [
          kakaoSchemeReceiverProvider.overrideWithValue(
            (onLink) => onKakaoLink = onLink,
          ),
        ],
        beforePump: (c) => mockReadApis(ApiMock(c), detailListId: 1),
      );
      expect(onKakaoLink, isNotNull);

      onKakaoLink!(Uri.parse('kakaoabc123://kakaolink?listId=1'));
      await settle(tester);

      final screen = tester.widget<ListDetailScreen>(
        find.byType(ListDetailScreen),
      );
      expect(screen.listId, '1');
    });

    testWidgets('앱이 꺼져 있을 때 deeplink 로 시작해도 그 화면이 열린다', (tester) async {
      tester.binding.platformDispatcher.defaultRouteNameTestValue =
          'listywave://list/1';
      addTearDown(
        tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
      );

      await _pumpDeepLinkApp(tester);
      await settle(tester);

      final screen = tester.widget<ListDetailScreen>(
        find.byType(ListDetailScreen),
      );
      expect(screen.listId, '1');
    });

    testWidgets('보호 경로 deeplink 는 비로그인이면 로그인 sheet 를 띄운다', (tester) async {
      await _pumpDeepLinkApp(tester);
      await _openDeepLink(tester, 'listywave://account');

      expect(find.byType(LoginSheet), findsOneWidget);
      final sheet = tester.widget<LoginSheet>(find.byType(LoginSheet));
      expect(sheet.from, AppRoutes.account);
    });
  });

  group('잘못된 deeplink', () {
    for (final url in [
      'listywave://unknown/path',
      'https://listywave.vercel.app/no/such/page',
      'otherapp://list/1',
    ]) {
      testWidgets('$url → not-found 화면, 홈 버튼으로 홈에 간다', (tester) async {
        await _pumpDeepLinkApp(tester);
        await _openDeepLink(tester, url);

        expect(find.byType(NotFoundScreen), findsOneWidget);
        expect(find.text('페이지를 찾을 수 없어요.'), findsOneWidget);

        await tester.tap(find.text('홈으로 가기'));
        await settle(tester);
        expect(find.byType(NotFoundScreen), findsNothing);
        expect(find.byType(HomeScreen), findsOneWidget);
      });
    }

    testWidgets('앱 안에서 모르는 경로로 가도 not-found 화면이다', (tester) async {
      final container = await pumpApp(tester);
      container.read(routerProvider).go('/does-not-exist');
      await settle(tester);

      expect(find.byKey(const Key('notFound')), findsOneWidget);
    });
  });
}
