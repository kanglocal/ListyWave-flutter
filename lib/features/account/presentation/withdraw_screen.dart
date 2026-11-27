import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/toast.dart';

/// web `/account/withdraw`: 안내, 동의 체크, 확인 modal 뒤 `DELETE /withdraw`.
class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  bool _agreed = false;
  bool _withdrawing = false;

  Future<void> _withdraw() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.account_withdrawModalMessage,
    );
    if (!confirmed || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    setState(() => _withdrawing = true);
    try {
      // 성공하면 로그아웃 상태가 되고 router 가 홈으로 보낸다 (authRedirect).
      await ref.read(authControllerProvider.notifier).withdraw();
      messenger.showSnackBar(SnackBar(content: Text(l10n.toast_withdraw)));
      router.go(AppRoutes.home);
    } on Exception {
      if (!mounted) return;
      setState(() => _withdrawing = false);
      showToast(context, l10n.toast_withdrawError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notes = [
      l10n.account_withdrawCheck3,
      l10n.account_withdrawCheck4,
      l10n.account_withdrawCheck5,
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.account_withdrawal, style: context.typo.bodyBold),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
          children: [
            Text(
              l10n.account_withdrawCheck1,
              textAlign: TextAlign.center,
              style: context.typo.subtitle,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.account_withdrawCheck2,
              textAlign: TextAlign.center,
              style: context.typo.label.copyWith(color: AppColors.red),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bggray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final note in notes)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('•', style: context.typo.label),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(note, style: context.typo.label),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              key: const Key('withdraw.agree'),
              value: _agreed,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) => setState(() => _agreed = value ?? false),
              title: Text(
                l10n.account_withdrawMessage,
                style: context.typo.label,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('withdraw.submit'),
              onPressed: _agreed && !_withdrawing ? _withdraw : null,
              child: Text(l10n.account_withdraw),
            ),
          ],
        ),
      ),
    );
  }
}
