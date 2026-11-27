import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/kakao_login_webview.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/features/account/presentation/withdrawn_account_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/onboarding/presentation/onboarding_screen.dart';

import '../../helpers/login_fixtures.dart';
import '../../helpers/pump_app.dart';

/// platform WebView 대신 navigation handler 를 잡아 두는 가짜 WebView.
class _FakeWebView {
  Uri? initialUrl;
  LoginNavigationHandler? onNavigationRequest;

  Widget build(Uri url, LoginNavigationHandler handler) {
    initialUrl = url;
    onNavigationRequest = handler;
    return const SizedBox(key: Key('fakeWebView'));
  }
}

void main() {
  late _FakeWebView webView;
  late List<Uri> launched;
  late ApiMock api;
  late Map<String, String> secure;

  Future<({ProviderContainer container, GoRouter router})> openKakaoLogin(
    WidgetTester tester,
    void Function(ApiMock api) mock,
  ) async {
    final container = await pumpApp(
      tester,
      secure: secure,
      overrides: [
        loginWebViewBuilderProvider.overrideWithValue(webView.build),
        externalUrlLauncherProvider.overrideWithValue((url) async {
          launched.add(url);
          throw Exception('카카오톡 없음');
        }),
      ],
      beforePump: (c) => mock(api = ApiMock(c)),
    );
    final router = container.read(routerProvider)..push(AppRoutes.login);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('login.kakao')));
    await tester.pumpAndSettle();
    return (container: container, router: router);
  }

  setUp(() {
    webView = _FakeWebView();
    launched = [];
    secure = {};
  });

  testWidgets('WebView 는 {API}/auth/kakao 를 열고, 카카오/외부 앱 navigation 을 구분한다', (
    tester,
  ) async {
    await openKakaoLogin(tester, (_) {});

    expect(find.byKey(const Key('fakeWebView')), findsOneWidget);
    expect(webView.initialUrl.toString(), 'http://localhost:8080/auth/kakao');
    final handler = webView.onNavigationRequest!;

    expect(
      await handler(
        Uri.parse('https://kauth.kakao.com/oauth/authorize?client_id=x'),
      ),
      LoginNavigationDecision.navigate,
    );
    // code 가 없으면 가로채지 않는다.
    expect(
      await handler(Uri.parse('http://localhost:3000/auth/redirect/kakao')),
      LoginNavigationDecision.navigate,
    );
    // 외부 앱 scheme 은 url_launcher 로 넘기고, 실패해도 WebView 에 머문다.
    final talk = Uri.parse('kakaotalk://login?x=1');
    expect(await handler(talk), LoginNavigationDecision.prevent);
    expect(
      await handler(Uri.parse('intent://login#Intent;scheme=kakaotalk;end')),
      LoginNavigationDecision.prevent,
    );
    expect(
      await handler(Uri.parse('kakaokompassauth://authorize')),
      LoginNavigationDecision.prevent,
    );
    expect(launched.first, talk);
    expect(launched, hasLength(3));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('fakeWebView')), findsOneWidget);
  });

  testWidgets(
    '.../auth/redirect/kakao?code=abc 는 prevent 되고 GET /auth/redirect/kakao?code=abc 를 부른다. isFirst 면 /start-listy',
    (tester) async {
      final (:container, :router) = await openKakaoLogin(tester, (api) {
        api.adapter.onGet(
          '/auth/redirect/kakao',
          (s) => s.reply(200, loginJson(id: 5, isFirst: true)),
          queryParameters: {'code': 'abc'},
        );
      });

      final decision = await webView.onNavigationRequest!(
        Uri.parse('https://listywave.vercel.app/auth/redirect/kakao?code=abc'),
      );
      await tester.pumpAndSettle();

      expect(decision, LoginNavigationDecision.prevent);
      final sent = api.sent('GET', '/auth/redirect/kakao');
      expect(sent, hasLength(1));
      expect(sent.single.uri.queryParameters, {'code': 'abc'});
      expect(locationOf(router), '/start-listy');
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.byType(LoginSheet), findsNothing);
      expect(
        container.read(authControllerProvider),
        const AuthState.loggedIn(5),
      );
      expect(secure, {'accessToken': 'at-5', 'refreshToken': 'rt-5'});
    },
  );

  testWidgets('탈퇴 회원 (400) 이면 /withdrawn-account 로 간다', (tester) async {
    final (:container, :router) = await openKakaoLogin(tester, (api) {
      api.adapter.onGet(
        '/auth/redirect/kakao',
        (s) => s.reply(400, {
          'status': 400,
          'error': 'BAD_REQUEST',
          'code': 'DELETED_USER_EXCEPTION',
          'detail': '탈퇴한 회원입니다.',
          'message': '탈퇴한 회원입니다.',
        }),
        queryParameters: {'code': 'gone'},
      );
    });

    final decision = await webView.onNavigationRequest!(
      Uri.parse('http://localhost:3000/auth/redirect/kakao?code=gone'),
    );
    await tester.pumpAndSettle();

    expect(decision, LoginNavigationDecision.prevent);
    expect(api.sent('GET', '/auth/redirect/kakao'), hasLength(1));
    expect(locationOf(router), '/withdrawn-account');
    expect(find.byType(WithdrawnAccountScreen), findsOneWidget);
    expect(container.read(authControllerProvider).status, AuthStatus.loggedOut);
    expect(secure, isEmpty);
  });

  testWidgets('정지 회원 (403 SUSPENDED_USER) 이면 안내하고 홈으로 간다', (tester) async {
    final (:container, :router) = await openKakaoLogin(tester, (api) {
      api.adapter.onGet(
        '/auth/redirect/kakao',
        (s) => s.reply(403, {
          'status': 403,
          'error': 'FORBIDDEN',
          'code': 'SUSPENDED_USER',
          'detail': '이용이 정지된 계정이에요. 문의는 고객센터로 부탁드려요.',
          'message': '이용이 정지된 계정이에요. 문의는 고객센터로 부탁드려요.',
        }),
        queryParameters: {'code': 'banned'},
      );
    });

    await webView.onNavigationRequest!(
      Uri.parse('http://localhost:3000/auth/redirect/kakao?code=banned'),
    );
    await tester.pumpAndSettle();

    expect(api.sent('GET', '/auth/redirect/kakao'), hasLength(1));
    expect(locationOf(router), '/');
    expect(find.byType(LoginSheet), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('이용이 정지된 계정이에요. 문의는 고객센터로 부탁드려요.'), findsOneWidget);
    expect(container.read(authControllerProvider).status, AuthStatus.loggedOut);
    expect(secure, isEmpty);
  });

  testWidgets('기존 회원이고 돌아갈 곳이 없으면 sheet 만 닫는다', (tester) async {
    final (:container, :router) = await openKakaoLogin(tester, (api) {
      api.adapter.onGet(
        '/auth/redirect/kakao',
        (s) => s.reply(200, loginJson(id: 2)),
        queryParameters: {'code': 'abc'},
      );
    });

    await webView.onNavigationRequest!(
      Uri.parse('http://localhost:3000/auth/redirect/kakao?code=abc'),
    );
    await tester.pumpAndSettle();

    expect(locationOf(router), '/');
    expect(find.byType(LoginSheet), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(container.read(authControllerProvider), const AuthState.loggedIn(2));
  });

  testWidgets('WebView 를 닫으면 로그인 요청을 보내지 않는다', (tester) async {
    await openKakaoLogin(tester, (_) {});

    await tester.tap(find.byKey(const Key('kakaoLogin.close')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('fakeWebView')), findsNothing);
    expect(find.byType(LoginSheet), findsOneWidget);
    // 뒤의 홈 화면은 조회 요청을 보내므로 인증 요청만 본다.
    expect(api.requests.where((r) => r.uri.path.startsWith('/auth')), isEmpty);
  });
}
