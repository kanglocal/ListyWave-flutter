import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/env.dart';
import '../l10n/gen/app_localizations.dart';
import '../network/app_exception.dart';
import '../theme/typography.dart';
import 'auth_controller.dart';
import 'kakao_login_webview.dart';
import 'login_response.dart';

/// web `src/components/login/LoginModal.tsx`. `/login` dialog page 로 뜬다.
///
/// 로그인에 성공하면 처음 가입한 사용자는 `/start-listy` 로, 아니면 [from] 으로 보낸다.
/// [from] 이 없으면 (하단 탭에서 띄운 경우) sheet 만 닫는다.
class LoginSheet extends ConsumerStatefulWidget {
  const LoginSheet({super.key, this.from});

  /// auth guard 가 막은 원래 위치.
  final String? from;

  @override
  ConsumerState<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends ConsumerState<LoginSheet> {
  bool _busy = false;

  Future<void> _loginWithKakao() async {
    final code = await KakaoLoginWebView.open(context);
    if (code == null || !mounted) return;
    await _login(
      () => ref.read(authControllerProvider.notifier).loginWithKakaoCode(code),
      isKakao: true,
    );
  }

  Future<void> _loginLocal() => _login(
    () => ref.read(authControllerProvider.notifier).loginLocal(),
    isKakao: false,
  );

  Future<void> _login(
    Future<LoginResponse> Function() login, {
    required bool isKakao,
  }) async {
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final failed = AppLocalizations.of(context).login_failed;
    setState(() => _busy = true);
    try {
      final response = await login();
      if (response.isFirst) {
        router.go('/start-listy');
      } else if (widget.from case final from?) {
        router.go(from);
      } else if (mounted) {
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      // 탈퇴 회원의 카카오 로그인은 400 `DELETED_USER_EXCEPTION` 이다 (`AuthService.java`).
      if (isKakao && AppException.from(e).status == 400) {
        router.go('/withdrawn-account');
      } else {
        messenger?.showSnackBar(SnackBar(content: Text(failed)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _close() {
    final router = GoRouter.of(context);
    // auth guard 가 `go` 로 띄운 경우 아래에 page 가 없으니 홈으로 보낸다.
    router.canPop() ? router.pop() : router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDev = ref.watch(envProvider).isDev;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/large_logo.svg',
            width: 207,
            height: 35,
            semanticsLabel: l10n.appTitle,
          ),
          const SizedBox(height: 16),
          Text(l10n.login_title, style: context.typo.bodyRegular),
          const SizedBox(height: 24),
          if (_busy)
            const CircularProgressIndicator()
          else ...[
            Semantics(
              button: true,
              label: l10n.login_kakao,
              child: InkWell(
                key: const Key('login.kakao'),
                onTap: _loginWithKakao,
                child: SvgPicture.asset('assets/icons/kakao_login.svg'),
              ),
            ),
            if (isDev)
              TextButton(
                key: const Key('login.local'),
                onPressed: _loginLocal,
                child: Text(l10n.login_local),
              ),
          ],
        ],
      ),
      actions: [TextButton(onPressed: _close, child: Text(l10n.common_close))],
    );
  }
}
