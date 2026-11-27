import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/env.dart';
import '../l10n/gen/app_localizations.dart';
import '../network/app_exception.dart';
import '../theme/colors.dart';
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
      final error = AppException.from(e);
      if (error.code == 'SUSPENDED_USER') {
        // 이용 정지 회원 (카카오·local 로그인 403). 안내는 dio 공통 처리
        // (`SuspendedUserInterceptor`) 가 띄우고, web 카카오 redirect 처럼 홈으로 보낸다.
        if (mounted) Navigator.of(context).pop();
        router.go('/');
        return;
      }
      // 탈퇴 회원의 카카오 로그인은 400 `DELETED_USER_EXCEPTION` 이다 (`AuthService.java`).
      if (isKakao && error.status == 400) {
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
    final text = context.typo.body.copyWith(color: AppColors.black);
    // web `LoginModal.tsx` 를 `Modal size="large"` (`Modal.css.ts`: 흰색, radius 30,
    // padding 60 25, 최소 327) 에 담은 모양. web 은 바깥을 눌러 닫지만 앱은 × 도 둔다.
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 327, maxWidth: 420),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/png/large_logo.png',
                    width: 207,
                    height: 35,
                    semanticLabel: l10n.appTitle,
                  ),
                  const SizedBox(height: 24),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: l10n.login_own),
                        TextSpan(
                          text: l10n.login_list,
                          style: text.copyWith(color: AppColors.blue),
                        ),
                        TextSpan(text: l10n.login_make),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: text,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.login_start,
                    style: context.typo.header.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 24),
                  // buttonContainer: 위 1px line, padding-top 24, gap 10.
                  const Divider(height: 1),
                  const SizedBox(height: 24),
                  if (_busy)
                    const CircularProgressIndicator()
                  else ...[
                    Semantics(
                      button: true,
                      label: l10n.login_kakao,
                      excludeSemantics: true,
                      child: InkWell(
                        key: const Key('login.kakao'),
                        borderRadius: BorderRadius.circular(12),
                        onTap: _loginWithKakao,
                        child: SvgPicture.asset(
                          'assets/icons/kakao_login_narrow.svg',
                        ),
                      ),
                    ),
                    if (isDev) ...[
                      const SizedBox(height: 10),
                      // buttonForLocal: 높이 47, 1px line, whiteblue, radius 12.
                      OutlinedButton(
                        key: const Key('login.local'),
                        onPressed: _loginLocal,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(183, 47),
                          backgroundColor: AppColors.whiteblue,
                          foregroundColor: AppColors.black,
                          side: const BorderSide(color: AppColors.line),
                          textStyle: context.typo.label,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.login_local),
                      ),
                    ],
                  ],
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                tooltip: l10n.common_close,
                onPressed: _close,
                icon: const Icon(Icons.close, color: AppColors.bluegray8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
