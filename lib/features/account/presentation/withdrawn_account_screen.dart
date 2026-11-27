import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import 'account_screen.dart';

/// web `/withdrawn-account`: 탈퇴 회원이 로그인하면 (400) 오는 안내.
class WithdrawnAccountScreen extends StatelessWidget {
  const WithdrawnAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.withdrawnAccount_message1,
                  textAlign: TextAlign.center,
                  style: context.typo.subtitle,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.withdrawnAccount_message2,
                  textAlign: TextAlign.center,
                  style: context.typo.body.copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 32),
                FilledButton(
                  key: const Key('withdrawnAccount.home'),
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text(l10n.withdrawnAccount_goToHome),
                ),
                TextButton(
                  onPressed: () => openExternal(contactUrl),
                  child: Text(l10n.withdrawnAccount_contact),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
