import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/floating_buttons.dart';
import '../../../core/widgets/user_profile_image.dart';
import '../../notification/application/notification_providers.dart';
import '../../user/application/user_providers.dart';
import '../application/home_providers.dart';
import 'widgets/feed_lists.dart';
import 'widgets/recommendation_feed.dart';

/// web `src/app/(home)` (layout Header + Feed).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(homeTabProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),
            const _HomeTabBar(),
            Expanded(
              child: FloatingButtonsScope(
                sharePath: AppRoutes.home,
                child: switch (tab) {
                  HomeTab.recommendation => const RecommendationFeed(),
                  HomeTab.recent => const RecentFeed(),
                  HomeTab.following => const FollowingFeed(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// web `(home)/_components/Header.tsx` (3.0). 검색창은 앱에서 검색 화면으로 이동한다.
/// `Header.css.ts`: 높이 40, padding 10 16, 아래 16. 제목 20/700, 아이콘 사이 9.
class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final userId = ref.watch(currentUserIdProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Text(
              l10n.home_title,
              style: context.typo.header.copyWith(
                letterSpacing: 0,
                color: AppColors.black,
              ),
            ),
            if (userId == null) ...[
              const SizedBox(width: 10),
              // authButton: 흰 pill, padding 4 6, bluegray10 600.
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => context.push(AppRoutes.login),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Text(
                      l10n.common_signInAndUp,
                      style: context.typo.label.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.39,
                        color: AppColors.bluegray10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const Spacer(),
            _HeaderIcon(
              tooltip: l10n.search_title,
              onTap: () => context.push(AppRoutes.search),
              child: SvgPicture.asset('assets/icons/ver3/search.svg'),
            ),
            if (userId != null) ...[
              _HeaderIcon(
                tooltip: l10n.common_goToNotification,
                onTap: () => context.push(AppRoutes.notification),
                // web Header 의 새 알림 점 (`/alarms/check-new`).
                child: Badge(
                  key: const Key('home.notificationBadge'),
                  isLabelVisible:
                      ref.watch(hasNewNotificationProvider).value ?? false,
                  smallSize: 7,
                  backgroundColor: AppColors.red,
                  child: SvgPicture.asset('assets/icons/ver3/bell.svg'),
                ),
              ),
              _HeaderIcon(
                tooltip: l10n.common_userProfileImage,
                onTap: () => context.push(AppRoutes.account),
                child: _HeaderAvatar(
                  src: ref.watch(userProvider(userId)).value?.profileImageUrl,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 헤더 아이콘 버튼. web 은 아이콘 사이가 9 라 터치 영역(40)을 겹치지 않게 좁게 잡는다.
class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 36, height: 40),
      icon: child,
    );
  }
}

/// web Header 의 프로필 (20px 원, 없으면 `ver3/Avatar.svg`).
class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.src});

  final String? src;

  @override
  Widget build(BuildContext context) {
    if (src == null || src!.isEmpty) {
      return SvgPicture.asset('assets/icons/ver3/Avatar.svg');
    }
    return UserProfileImage(src: src, size: 20);
  }
}

/// web `HomeTab.tsx` (3.0). `HomeTab.css.ts`: padding 0 16, 아래 16, 버튼 사이 18.
/// 비선택은 16/400 `bluegray8`, 선택은 흰 글자에 blue pill (padding 6 12, radius 20).
class _HomeTabBar extends ConsumerWidget {
  const _HomeTabBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(homeTabProvider);
    final labels = {
      HomeTab.recommendation: l10n.home_tabRecommendation,
      HomeTab.recent: l10n.home_tabRecent,
      HomeTab.following: l10n.home_tabFollowing,
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          for (final (i, MapEntry(key: tab, value: label))
              in labels.entries.indexed) ...[
            if (i > 0) const SizedBox(width: 18),
            Semantics(
              button: true,
              selected: tab == current,
              child: InkWell(
                key: Key('homeTab.${tab.name}'),
                borderRadius: BorderRadius.circular(20),
                onTap: () => ref.read(homeTabProvider.notifier).select(tab),
                child: Container(
                  padding: tab == current
                      ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
                      : const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: tab == current ? AppColors.blue : null,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: context.typo.bodyRegular.copyWith(
                      letterSpacing: 0,
                      color: tab == current
                          ? AppColors.white
                          : AppColors.bluegray8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
