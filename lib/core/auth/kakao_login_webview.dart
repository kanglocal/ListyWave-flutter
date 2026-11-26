import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/env.dart';
import '../l10n/gen/app_localizations.dart';

enum LoginNavigationDecision { navigate, prevent }

typedef LoginNavigationHandler =
    Future<LoginNavigationDecision> Function(Uri url);

/// WebView 구현을 감춘다. 테스트는 platform WebView 없이 [LoginNavigationHandler] 를 직접 부른다.
typedef LoginWebViewBuilder =
    Widget Function(Uri initialUrl, LoginNavigationHandler onNavigationRequest);

final loginWebViewBuilderProvider = Provider<LoginWebViewBuilder>(
  (ref) =>
      (initialUrl, onNavigationRequest) => _PlatformLoginWebView(
        initialUrl: initialUrl,
        onNavigationRequest: onNavigationRequest,
      ),
);

/// 외부 앱 실행 (카카오톡 로그인). 실패하면 false 다.
final externalUrlLauncherProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
);

/// 로그아웃 때 WebView 에 남은 카카오 계정 세션을 지운다 (PLAN §4.2).
final clearWebViewCookiesProvider = Provider<Future<void> Function()>(
  (ref) =>
      () => WebViewCookieManager().clearCookies(),
);

const _kakaoRedirectPath = '/auth/redirect/kakao';
const _externalSchemes = {'intent', 'kakaotalk', 'kakaokompassauth'};

/// 카카오가 redirect_uri 로 보내는 navigation 이면 인가 code 를 준다.
/// dev/prod 의 redirect_uri host 가 달라도 되도록 path 로만 비교한다.
String? kakaoAuthCodeOf(Uri url) {
  if (!url.path.endsWith(_kakaoRedirectPath)) return null;
  final code = url.queryParameters['code'];
  return code == null || code.isEmpty ? null : code;
}

bool isExternalAppUrl(Uri url) => _externalSchemes.contains(url.scheme);

/// `GET {API}/auth/kakao` 를 열고, 카카오가 redirect 하는 순간 code 를 가로채 돌려준다.
/// 웹 페이지가 code 를 먼저 쓰지 못하게 그 navigation 은 막는다.
class KakaoLoginWebView extends ConsumerStatefulWidget {
  const KakaoLoginWebView({super.key});

  /// 전체 화면으로 띄운다. 사용자가 닫으면 null 이다.
  static Future<String?> open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).push<String>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const KakaoLoginWebView(),
        ),
      );

  @override
  ConsumerState<KakaoLoginWebView> createState() => _KakaoLoginWebViewState();
}

class _KakaoLoginWebViewState extends ConsumerState<KakaoLoginWebView> {
  bool _done = false;

  Future<LoginNavigationDecision> _onNavigationRequest(Uri url) async {
    final code = kakaoAuthCodeOf(url);
    if (code != null) {
      if (!_done && mounted) {
        _done = true;
        Navigator.of(context).pop(code);
      }
      return LoginNavigationDecision.prevent;
    }
    if (isExternalAppUrl(url)) {
      // 카카오톡이 없거나 열 수 없으면 카카오계정 로그인 화면에 머문다.
      try {
        await ref.read(externalUrlLauncherProvider)(url);
      } on Exception catch (e) {
        debugPrint('KakaoLoginWebView: 외부 앱 실행 실패 무시 ($e)');
      }
      return LoginNavigationDecision.prevent;
    }
    return LoginNavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    final apiBaseUrl = ref.watch(envProvider).apiBaseUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).login_kakao),
        leading: IconButton(
          key: const Key('kakaoLogin.close'),
          icon: const Icon(Icons.close),
          tooltip: AppLocalizations.of(context).common_close,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ref.watch(loginWebViewBuilderProvider)(
        Uri.parse('$apiBaseUrl/auth/kakao'),
        _onNavigationRequest,
      ),
    );
  }
}

class _PlatformLoginWebView extends StatefulWidget {
  const _PlatformLoginWebView({
    required this.initialUrl,
    required this.onNavigationRequest,
  });

  final Uri initialUrl;
  final LoginNavigationHandler onNavigationRequest;

  @override
  State<_PlatformLoginWebView> createState() => _PlatformLoginWebViewState();
}

class _PlatformLoginWebViewState extends State<_PlatformLoginWebView> {
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) async {
          final url = Uri.tryParse(request.url);
          if (url == null) return NavigationDecision.navigate;
          final decision = await widget.onNavigationRequest(url);
          return decision == LoginNavigationDecision.prevent
              ? NavigationDecision.prevent
              : NavigationDecision.navigate;
        },
        // 일부 platform 은 server redirect 를 onNavigationRequest 로 알리지 않는다.
        // 그때도 code 를 놓치지 않도록 페이지 시작 시점에 한 번 더 확인한다.
        onPageStarted: (url) {
          final uri = Uri.tryParse(url);
          if (uri != null && kakaoAuthCodeOf(uri) != null) {
            _controller.loadHtmlString('<html></html>');
            widget.onNavigationRequest(uri);
          }
        },
      ),
    )
    ..loadRequest(widget.initialUrl);

  @override
  Widget build(BuildContext context) => WebViewWidget(controller: _controller);
}
