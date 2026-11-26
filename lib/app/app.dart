import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/auth/auth_controller.dart';
import '../core/l10n/gen/app_localizations.dart';
import '../core/theme/app_theme.dart';
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
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: ref.watch(routerProvider),
      // web 기본 언어(ko)를 따른다. 언어 토글은 localeControllerProvider 로 붙인다.
      locale: const Locale('ko'),
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
