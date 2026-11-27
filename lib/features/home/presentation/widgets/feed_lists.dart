import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router.dart';
import '../../../../core/auth/current_user.dart';
import '../../../../core/category/category_api.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/home_type.dart';
import '../../../../core/pagination/cursor_page.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/infinite_scroll.dart';
import '../../../../core/widgets/no_data.dart';
import '../../../../core/widgets/simple_list.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../application/home_providers.dart';
import '../../../../core/widgets/category_chips.dart';

/// web `RecentFeed.tsx`: 카테고리 + 최신 피드.
class RecentFeed extends ConsumerStatefulWidget {
  const RecentFeed({super.key});

  @override
  ConsumerState<RecentFeed> createState() => _RecentFeedState();
}

class _RecentFeedState extends ConsumerState<RecentFeed> {
  String _category = entireCategoryName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = recentFeedProvider(_category);
    return _FeedScroll(
      state: ref.watch(provider),
      onLoadMore: () => ref.read(provider.notifier).loadMore(),
      onRetry: () => ref.invalidate(provider),
      header: CategoryChips(
        wrap: true,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        selectedEngName: _category,
        onSelected: (category) => setState(() => _category = category.engName),
      ),
      empty: NoDataView(
        image: SvgPicture.asset(
          'assets/images/no_data_image.svg',
          width: 120,
          height: 120,
        ),
        message: l10n.home_noRecentList,
        description: l10n.home_noRecentListDescription,
        buttonLabel: l10n.home_goToRecommendedLists,
        onButtonPressed: () =>
            ref.read(homeTabProvider.notifier).select(HomeTab.recommendation),
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Text(l10n.home_recentEnd, style: context.typo.bodyBold),
            const SizedBox(height: 4),
            Text(
              l10n.home_recentPolicy,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }
}

/// web `FollowingFeed.tsx`. 비로그인이면 로그인 안내를 보인다.
class FollowingFeed extends ConsumerWidget {
  const FollowingFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (ref.watch(currentUserIdProvider) == null) {
      return SingleChildScrollView(
        child: NoDataView(
          message: l10n.home_followingLoginRequired,
          buttonLabel: l10n.home_goToLogin,
          onButtonPressed: () => context.push(AppRoutes.login),
        ),
      );
    }
    return _FeedScroll(
      state: ref.watch(followingFeedProvider),
      onLoadMore: () => ref.read(followingFeedProvider.notifier).loadMore(),
      onRetry: () => ref.invalidate(followingFeedProvider),
      empty: NoDataView(
        message: l10n.home_noFollowing,
        buttonLabel: l10n.home_goToRecommendedUsers,
        onButtonPressed: () =>
            ref.read(homeTabProvider.notifier).select(HomeTab.recommendation),
      ),
    );
  }
}

/// web `FeedLists.tsx`. 처음 불러올 때만 skeleton 을 보인다.
class _FeedScroll extends StatelessWidget {
  const _FeedScroll({
    required this.state,
    required this.onLoadMore,
    required this.onRetry,
    required this.empty,
    this.header,
    this.footer,
  });

  final AsyncValue<PageState<ListRecommendationType, String>> state;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;
  final Widget empty;
  final Widget? header;

  /// 끝까지 불러왔을 때만 보인다 (목록이 비면 보이지 않는다).
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final page = state.value;
    final List<Widget> body;
    if (page == null && state.hasError) {
      body = [
        SliverToBoxAdapter(
          child: ErrorView(error: state.error!, onRetry: onRetry),
        ),
      ];
    } else if (page == null) {
      body = [
        SliverToBoxAdapter(
          child: Skeletonizer(
            child: Column(
              children: [
                for (var i = 0; i < 3; i++)
                  const FeedListCard(item: _skeletonItem),
              ],
            ),
          ),
        ),
      ];
    } else if (page.items.isEmpty) {
      body = [SliverToBoxAdapter(child: empty)];
    } else {
      body = [
        SliverList.builder(
          itemCount: page.items.length,
          itemBuilder: (context, index) =>
              FeedListCard(item: page.items[index]),
        ),
        if (page.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        if (page.loadMoreError != null)
          SliverToBoxAdapter(
            child: ErrorView(error: page.loadMoreError!, onRetry: onLoadMore),
          ),
        if (!page.hasNext && footer != null) SliverToBoxAdapter(child: footer),
      ];
    }
    return InfiniteScroll(
      canLoadMore:
          page != null &&
          page.hasNext &&
          !page.isLoadingMore &&
          page.loadMoreError == null,
      onLoadMore: onLoadMore,
      child: CustomScrollView(
        key: const Key('home.feed'),
        slivers: [
          if (header != null) SliverToBoxAdapter(child: header),
          SliverPadding(
            // web FeedLists.css.ts wrapperOuter: margin-top 12, padding 0 16 84.
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 84),
            sliver: SliverMainAxisGroup(slivers: body),
          ),
        ],
      ),
    );
  }
}

const _skeletonItem = ListRecommendationType(
  id: 0,
  ownerId: 0,
  ownerNickname: 'nickname',
  ownerProfileImage: null,
  title: 'skeleton list title',
  description: 'skeleton list description',
  items: [
    HomeListItemType(id: 1, rank: 1, title: 'first item'),
    HomeListItemType(id: 2, rank: 2, title: 'second item'),
    HomeListItemType(id: 3, rank: 3, title: 'third item'),
  ],
  updateCount: 0,
);

/// web `FeedLists.tsx` FeedListItem (3.0, `FeedLists.css.ts`): 흰 카드 radius 24, padding 30 24 14.
class FeedListCard extends StatelessWidget {
  const FeedListCard({super.key, required this.item});

  final ListRecommendationType item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => context.push(AppRoutes.listDetail('${item.id}')),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () =>
                          context.push(AppRoutes.myList('${item.ownerId}')),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserProfileImage(
                            src: item.ownerProfileImage,
                            size: 30,
                            semanticLabel: l10n.common_listOwnerImage,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              item.ownerNickname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typo.bodyRegular.copyWith(
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.48,
                                color: AppColors.gray2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // version: whiteblue pill, blue 14/400.
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteblue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.home_updateCount(item.updateCount),
                    style: context.typo.label.copyWith(color: AppColors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: context.typo.header.copyWith(color: AppColors.black3),
            ),
            if (item.description?.isNotEmpty ?? false) ...[
              const SizedBox(height: 13),
              Text(
                item.description!,
                style: context.typo.bodyRegular.copyWith(
                  letterSpacing: 0,
                  color: AppColors.black3,
                ),
              ),
            ],
            const SizedBox(height: 20),
            // simpleListWrapper: 위 1px line, padding 20 16, 아래 16.
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.line)),
              ),
              child: SimpleRankList(
                items: [
                  for (final i in item.items) (rank: i.rank, title: i.title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
