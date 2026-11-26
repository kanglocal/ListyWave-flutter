import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/user_profile_image.dart';
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
      backgroundColor: AppColors.bggray,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),
            const _HomeTabBar(),
            Expanded(
              child: switch (tab) {
                HomeTab.recommendation => const RecommendationFeed(),
                HomeTab.recent => const RecentFeed(),
                HomeTab.following => const FollowingFeed(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// web `(home)/_components/Header.tsx`. 검색창은 앱에서 검색 화면으로 이동한다.
class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final userId = ref.watch(currentUserIdProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
      child: Row(
        children: [
          Text(l10n.home_title, style: context.typo.header),
          if (userId == null) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => context.push(AppRoutes.login),
              child: Text(
                l10n.common_signInAndUp,
                style: context.typo.label.copyWith(color: AppColors.gray),
              ),
            ),
          ],
          const Spacer(),
          IconButton(
            tooltip: l10n.search_title,
            onPressed: () => context.push(AppRoutes.search),
            icon: SvgPicture.asset('assets/icons/ver3/search.svg'),
          ),
          if (userId != null) ...[
            IconButton(
              tooltip: l10n.common_goToNotification,
              onPressed: () => context.push(AppRoutes.notification),
              icon: SvgPicture.asset('assets/icons/ver3/bell.svg'),
            ),
            IconButton(
              tooltip: l10n.common_userProfileImage,
              onPressed: () => context.push(AppRoutes.account),
              icon: UserProfileImage(
                src: ref.watch(userProvider(userId)).value?.profileImageUrl,
                size: 28,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// web `HomeTab.tsx`.
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          for (final MapEntry(key: tab, value: label) in labels.entries)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: InkWell(
                key: Key('homeTab.${tab.name}'),
                onTap: () => ref.read(homeTabProvider.notifier).select(tab),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: tab == current
                            ? AppColors.black
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    label,
                    style: context.typo.bodyBold.copyWith(
                      color: tab == current
                          ? AppColors.black
                          : AppColors.lightgray,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
