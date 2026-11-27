import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/router.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/l10n/locale_controller.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/listy_header.dart';
import '../../../core/widgets/segmented_control.dart';

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
      appBar: ListyHeader(title: l10n.account_settings),
      // web `account/page.css.ts`: padding 0 16, 섹션 사이 12.
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        children: [
          _Section(
            children: [
              _Row(
                key: const Key('account.profile'),
                icon: 'assets/icons/user.svg',
                title: l10n.account_profileSetting,
                onTap: () => context.push(AppRoutes.accountProfile),
              ),
            ],
          ),
          _Section(
            children: [
              _Row(
                icon: 'assets/icons/globe.svg',
                title: l10n.account_language,
                trailing: SegmentedControl<AppLanguage>(
                  key: const Key('account.language'),
                  segments: [
                    Segment(
                      key: const Key('account.language.ko'),
                      value: AppLanguage.ko,
                      label: l10n.account_korean,
                    ),
                    Segment(
                      key: const Key('account.language.en'),
                      value: AppLanguage.en,
                      label: l10n.account_english,
                    ),
                  ],
                  selected: language,
                  onChanged: (selected) => ref
                      .read(localeControllerProvider.notifier)
                      .select(selected),
                ),
              ),
            ],
          ),
          _Section(
            children: [
              _Row(
                icon: 'assets/icons/help_circle.svg',
                title: l10n.account_contact,
                onTap: () => openExternal(contactUrl),
              ),
              _Row(
                icon: 'assets/icons/message_square.svg',
                title: l10n.account_sendFeedback,
                onTap: () => openExternal(feedbackUrl),
              ),
            ],
          ),
          // accountFooter: 위 30, 사이 10, Label bluegray8.
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                key: const Key('account.logout'),
                onPressed: () => _logout(context, ref),
                style: _footerButton(context),
                child: Text(l10n.account_logout),
              ),
              Text(
                '|',
                style: context.typo.label.copyWith(color: AppColors.bluegray8),
              ),
              TextButton(
                key: const Key('account.withdraw'),
                onPressed: () => context.push(AppRoutes.accountWithdraw),
                style: _footerButton(context),
                child: Text(l10n.account_withdrawal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

ButtonStyle _footerButton(BuildContext context) => TextButton.styleFrom(
  foregroundColor: AppColors.bluegray8,
  textStyle: context.typo.label,
);

/// web baseDiv/buttonDiv: LabelBold, padding 16 32, 아이콘 24 과 글자 사이 16, 오른쪽 chevron 16.
class _Row extends StatelessWidget {
  const _Row({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });

  final String icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 24, height: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: context.typo.labelBold.copyWith(color: AppColors.black),
            ),
          ),
          trailing ??
              SvgPicture.asset(
                'assets/icons/chevron_right.svg',
                width: 16,
                height: 16,
              ),
        ],
      ),
    );
    if (onTap == null) return row;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: row,
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
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(children: children),
  );
}
