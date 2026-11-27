import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/category/category_api.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/list_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/category_chips.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/infinite_scroll.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/user_profile_image.dart';
import '../../follow/application/follow_providers.dart';
import '../../follow/presentation/widgets/follow_button.dart';
import '../application/user_providers.dart';
import '../data/user_api.dart';
import 'widgets/list_card.dart';

/// web `/user/[userId]/mylist` 와 `/collabolist` 는 같은 화면의 탭이다.
enum UserProfileTab { my, collabo }

/// web `user/[userId]/{mylist,collabolist}/page.tsx` (Profile + Content).
class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key, required this.userId, required this.tab});

  final String userId;
  final UserProfileTab tab;

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  String _category = entireCategoryName;

  UserListsQuery _query(int userId) => (
    userId: userId,
    type: widget.tab == UserProfileTab.my
        ? UserListType.my
        : UserListType.collabo,
    category: _category,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userId = int.tryParse(widget.userId);
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: NoDataView(
          message: l10n.error_loadFailed,
          buttonLabel: l10n.common_confirm,
          onButtonPressed: () => context.go(AppRoutes.home),
        ),
      );
    }
    final user = ref.watch(userProvider(userId));
    if (user case AsyncError(:final error) when !user.hasValue) {
      // web `Profile.tsx`: 탈퇴/없는 회원이면 서버 메시지를 보이고 홈으로 보낸다.
      final exception = AppException.from(error);
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: NoDataView(
            message: exception.status != null && exception.message.isNotEmpty
                ? exception.message
                : l10n.error_loadFailed,
            buttonLabel: l10n.common_confirm,
            onButtonPressed: () => context.go(AppRoutes.home),
          ),
        ),
      );
    }
    final listsProvider = userListsProvider(_query(userId));
    final lists = ref.watch(listsProvider);
    final page = lists.value;
    final owner = user.value;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: InfiniteScroll(
        canLoadMore:
            page != null &&
            page.hasNext &&
            !page.isLoadingMore &&
            page.loadMoreError == null,
        onLoadMore: () => ref.read(listsProvider.notifier).loadMore(),
        child: RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(userProvider(userId))
              ..invalidate(listsProvider);
            await ref.read(listsProvider.future);
          },
          child: CustomScrollView(
            key: const Key('userProfile.scroll'),
            slivers: [
              SliverToBoxAdapter(
                child: _ProfileHeader(userId: userId, user: owner),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.user_listTitle(owner?.nickname ?? ''),
                          style: context.typo.subtitle,
                        ),
                      ),
                      if (owner?.isOwner ?? false)
                        TextButton.icon(
                          onPressed: () => context.push(AppRoutes.collection),
                          icon: SvgPicture.asset(
                            'assets/icons/ver3/bookmark.svg',
                            width: 18,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blue,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: Text(
                            l10n.user_collection,
                            style: context.typo.labelBold.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _TabToggle(userId: widget.userId, tab: widget.tab),
              ),
              SliverToBoxAdapter(
                child: CategoryChips(
                  selectedEngName: _category,
                  onSelected: (c) => setState(() => _category = c.engName),
                ),
              ),
              ..._listSlivers(context, lists, owner, userId),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listSlivers(
    BuildContext context,
    AsyncValue<PageState<ListType, String>> state,
    UserType? owner,
    int userId,
  ) {
    final l10n = AppLocalizations.of(context);
    final provider = userListsProvider(_query(userId));
    final page = state.value;
    if (page == null && state.hasError) {
      return [
        SliverToBoxAdapter(
          child: ErrorView(
            error: state.error!,
            onRetry: () => ref.invalidate(provider),
          ),
        ),
      ];
    }
    if (page == null || owner == null) {
      return [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Skeletonizer(
              child: Row(
                children: [
                  for (var i = 0; i < 2; i++)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListCard(list: _skeletonList, isOwner: false),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ];
    }
    // web: 주인이 아니면 공개 리스트만 보인다.
    final visible = owner.isOwner
        ? page.items
        : page.items.where((l) => l.isPublic).toList();
    if (visible.isEmpty) {
      return [
        SliverToBoxAdapter(child: NoDataView(message: l10n.user_noListMessage)),
      ];
    }
    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 84),
        sliver: SliverMasonryGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childCount: visible.length,
          itemBuilder: (context, index) =>
              ListCard(list: visible[index], isOwner: owner.isOwner),
        ),
      ),
      if (page.isLoadingMore)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 84),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      if (page.loadMoreError != null)
        SliverToBoxAdapter(
          child: ErrorView(
            error: page.loadMoreError!,
            onRetry: () => ref.read(provider.notifier).loadMore(),
          ),
        ),
    ];
  }
}

const _skeletonList = ListType(
  id: 0,
  title: 'skeleton list',
  isPublic: true,
  backgroundColor: 'PASTEL_SKYBLUE',
  category: 'category',
  listItems: [
    ListItemType(id: 1, rank: 1, title: 'first item', imageUrl: null),
    ListItemType(id: 2, rank: 2, title: 'second item', imageUrl: null),
    ListItemType(id: 3, rank: 3, title: 'third item', imageUrl: null),
  ],
);

/// 마이 리스트 / 콜라보 리스트 전환. web 은 두 경로를 따로 두지만 화면 안에 이동 버튼이 없다.
class _TabToggle extends StatelessWidget {
  const _TabToggle({required this.userId, required this.tab});

  final String userId;
  final UserProfileTab tab;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: SegmentedButton<UserProfileTab>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: UserProfileTab.my,
            label: Text(l10n.user_myList),
          ),
          ButtonSegment(
            value: UserProfileTab.collabo,
            label: Text(l10n.user_collaboList),
          ),
        ],
        selected: {tab},
        onSelectionChanged: (selected) => context.replace(
          selected.first == UserProfileTab.my
              ? AppRoutes.myList(userId)
              : AppRoutes.collaboList(userId),
        ),
      ),
    );
  }
}

/// web `user/[userId]/_components/Profile.tsx`. 다른 사람의 프로필이면 팔로우 버튼을 보인다.
class _ProfileHeader extends ConsumerWidget {
  const _ProfileHeader({required this.userId, required this.user});

  final int userId;
  final UserType? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final u = user;
    // 낙관적 팔로우 값이 서버 값과 다르면 팔로워 수를 그만큼 고쳐 보인다 (web onMutate).
    final serverFollowed = u?.isFollowed ?? false;
    final followed = watchIsFollowing(ref, userId, serverValue: serverFollowed);
    final followerCount =
        (u?.followerCount ?? 0) +
        (followed == serverFollowed ? 0 : (followed ? 1 : -1));
    final textStyle = context.typo.label.copyWith(color: AppColors.white);
    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppNetworkImage(
            url: u?.backgroundImageUrl,
            fallback: Image.asset(
              'assets/images/fallback_backgroundImage.webp',
              fit: BoxFit.cover,
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0x99000000)],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topRight,
              child: u?.isOwner ?? false
                  ? IconButton(
                      tooltip: l10n.user_goToMypage,
                      onPressed: () => context.push(AppRoutes.account),
                      icon: SvgPicture.asset(
                        'assets/icons/setting.svg',
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : (Navigator.of(context).canPop()
                        ? const Align(
                            alignment: Alignment.topLeft,
                            child: BackButton(color: AppColors.white),
                          )
                        : const SizedBox.shrink()),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Skeletonizer(
              enabled: u == null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileImage(
                    src: u?.profileImageUrl,
                    size: 50,
                    semanticLabel: l10n.user_profileImageAlt,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          u?.nickname ?? 'nickname',
                          style: context.typo.subtitle.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  context.push(AppRoutes.followers('$userId')),
                              child: Text(
                                '${formatCount(followerCount)} ${l10n.user_follower}',
                                style: textStyle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () =>
                                  context.push(AppRoutes.followings('$userId')),
                              child: Text(
                                '${formatCount(u?.followingCount ?? 0)} ${l10n.user_following}',
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          (u?.description?.isNotEmpty ?? false)
                              ? u!.description!
                              : l10n.user_noDescription,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  if (u != null && !u.isOwner) ...[
                    const SizedBox(width: 8),
                    FollowButton(
                      userId: userId,
                      isFollowed: u.isFollowed,
                      profileStyle: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
