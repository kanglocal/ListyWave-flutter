import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/auth/auth_controller.dart';
import '../core/l10n/gen/app_localizations.dart';
import '../core/l10n/locale_controller.dart';
import '../core/network/suspended_user_interceptor.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/toast.dart';
import 'router.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ListyWaveApp extends ConsumerWidget {
  const ListyWaveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 토큰 갱신이 실패해 로그아웃되면 알린다 (web axiosInstance.ts userStatusLoggedOut).
    ref.listen(authControllerProvider, (previous, next) {
      final messenger = rootScaffoldMessengerKey.currentState;
      if (next.reason != LogoutReason.expired ||
          previous?.reason == LogoutReason.expired ||
          messenger == null) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(messenger.context).toast_userStatusLoggedOut,
          ),
        ),
      );
    });
    // 이용 정지 회원의 요청이 403 SUSPENDED_USER 로 막히면 알린다 (web axiosInstance.ts).
    ref.listen(suspendedUserNoticeProvider, (_, _) {
      final messenger = rootScaffoldMessengerKey.currentState;
      if (messenger == null) return;
      showSuspendedNotice(
        messenger,
        AppLocalizations.of(messenger.context).toast_suspendedUser,
      );
    });
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: ref.watch(routerProvider),
      // web 기본 언어(ko). 계정 화면의 언어 토글이 바꾸고 저장한다 (PLAN §5.5).
      locale: ref.watch(localeControllerProvider).locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
