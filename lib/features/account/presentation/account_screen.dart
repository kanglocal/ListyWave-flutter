import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/router.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/l10n/locale_controller.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/confirm_dialog.dart';

/// web `account/page.tsx` 의 외부 링크.
const contactUrl = 'https://open.kakao.com/o/saz6DObg';
const feedbackUrl = 'https://tally.so/r/w51Dpv';

Future<void> openExternal(String url) =>
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

/// web `/account`: 프로필 설정, 언어, 문의/의견, 로그아웃, 회원탈퇴.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.account_logoutMessage,
    );
    if (!confirmed || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    // 서버 로그아웃이 실패해도 로컬 세션은 지운다 (PLAN §4.3). web 과 같이 홈으로 간다.
    await ref.read(authControllerProvider.notifier).logout(LogoutReason.user);
    messenger.showSnackBar(SnackBar(content: Text(l10n.toast_loggedOut)));
    router.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final language = ref.watch(localeControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.bggray,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.bggray,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.account_settings, style: context.typo.bodyBold),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          _Section(
            children: [
              ListTile(
                key: const Key('account.profile'),
                leading: const Icon(Icons.person_outline),
                title: Text(l10n.account_profileSetting),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.accountProfile),
              ),
            ],
          ),
          _Section(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.account_language),
                trailing: SegmentedButton<AppLanguage>(
                  key: const Key('account.language'),
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: AppLanguage.ko,
                      label: Text(
                        l10n.account_korean,
                        key: const Key('account.language.ko'),
                      ),
                    ),
                    ButtonSegment(
                      value: AppLanguage.en,
                      label: Text(
                        l10n.account_english,
                        key: const Key('account.language.en'),
                      ),
                    ),
                  ],
                  selected: {language},
                  onSelectionChanged: (selected) => ref
                      .read(localeControllerProvider.notifier)
                      .select(selected.single),
                ),
              ),
            ],
          ),
          _Section(
            children: [
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(l10n.account_contact),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => openExternal(contactUrl),
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: Text(l10n.account_sendFeedback),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => openExternal(feedbackUrl),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                key: const Key('account.logout'),
                onPressed: () => _logout(context, ref),
                child: Text(
                  l10n.account_logout,
                  style: context.typo.label.copyWith(color: AppColors.gray),
                ),
              ),
              Text(
                '|',
                style: context.typo.label.copyWith(color: AppColors.gray),
              ),
              TextButton(
                key: const Key('account.withdraw'),
                onPressed: () => context.push(AppRoutes.accountWithdraw),
                child: Text(
                  l10n.account_withdrawal,
                  style: context.typo.label.copyWith(color: AppColors.gray),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(children: children),
  );
}
