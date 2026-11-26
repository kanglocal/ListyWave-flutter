import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/home_type.dart';
import '../../../../core/models/user_profile_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../application/home_providers.dart';

/// web `RecommendationFeed.tsx`: 추천 리스트 swiper + 추천 주제 + 추천 리스터.
class RecommendationFeed extends ConsumerWidget {
  const RecommendationFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref
          ..invalidate(homeRecommendedListsProvider)
          ..invalidate(recommendedTopicsProvider)
          ..invalidate(recommendedUsersProvider);
        await ref.read(homeRecommendedListsProvider.future);
      },
      child: ListView(
        key: const Key('home.recommendation'),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 84),
        children: const [
          HomeRecommendedLists(),
          TopicsRecommendation(),
          UsersRecommendation(),
        ],
      ),
    );
  }
}

/// web `HomeRecommendedLists.tsx` (swiper: 가운데 정렬, loop, 1.5초 autoplay).
class HomeRecommendedLists extends ConsumerWidget {
  const HomeRecommendedLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(homeRecommendedListsProvider);
    return switch (lists) {
      AsyncData(:final value) when value.isEmpty => const SizedBox.shrink(),
      AsyncData(:final value) => _RecommendedSwiper(items: value),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(homeRecommendedListsProvider),
      ),
      _ => const SizedBox(
        height: 300,
        child: Skeletonizer(
          child: Center(
            child: _RecommendedListItem(
              item: HomeRecommendedListType(
                id: 0,
                ownerId: 0,
                ownerNickname: 'nickname',
                title: 'recommended list',
                itemImageUrl: null,
                category: 'category',
                backgroundColor: '',
                items: [
                  Top3Type(id: 1, rank: 1, title: 'first item'),
                  Top3Type(id: 2, rank: 2, title: 'second item'),
                  Top3Type(id: 3, rank: 3, title: 'third item'),
                ],
              ),
            ),
          ),
        ),
      ),
    };
  }
}

class _RecommendedSwiper extends StatefulWidget {
  const _RecommendedSwiper({required this.items});

  final List<HomeRecommendedListType> items;

  @override
  State<_RecommendedSwiper> createState() => _RecommendedSwiperState();
}

class _RecommendedSwiperState extends State<_RecommendedSwiper> {
  /// loop 를 위해 가운데에서 시작한다.
  static const _loopBase = 1000;

  late final PageController _controller;
  Timer? _autoplay;
  late int _page;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _page = widget.items.length * _loopBase;
    _controller = PageController(initialPage: _page, viewportFraction: 0.7);
    _autoplay = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      // 다른 화면에 가려져 있으면 (TickerMode off) 넘기지 않는다.
      if (!_controller.hasClients || !_visible) {
        return;
      }
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _autoplay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _visible = TickerMode.of(context);
    final count = widget.items.length;
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            key: const Key('home.recommendedSwiper'),
            controller: _controller,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _RecommendedListItem(item: widget.items[index % count]),
            ),
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _page % count,
          count: count,
          effect: const WormEffect(
            dotWidth: 6,
            dotHeight: 6,
            activeDotColor: AppColors.blue,
            dotColor: AppColors.bluegray6,
          ),
        ),
      ],
    );
  }
}

/// web RecommendedListsItem. 대표 이미지가 있으면 원형 이미지 배경, 없으면 흰 둥근 사각형.
class _RecommendedListItem extends StatelessWidget {
  const _RecommendedListItem({required this.item});

  final HomeRecommendedListType item;

  @override
  Widget build(BuildContext context) {
    final hasImage = item.itemImageUrl?.isNotEmpty ?? false;
    final textColor = hasImage ? AppColors.white : AppColors.black;
    final radius = hasImage ? 140.0 : 38.0;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.listDetail('${item.id}')),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (hasImage) ...[
                AppNetworkImage(url: item.itemImageUrl),
                const ColoredBox(color: Color(0x66000000)),
              ] else
                const ColoredBox(color: AppColors.white),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 36,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.skyblue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.category,
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.subtitle.copyWith(color: textColor),
                    ),
                    Text(
                      item.ownerNickname,
                      style: context.typo.labelSmall.copyWith(color: textColor),
                    ),
                    const SizedBox(height: 8),
                    for (final (index, top) in item.items.indexed)
                      Text(
                        '${index + 1}. ${top.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.typo.label.copyWith(
                          color: hasImage ? AppColors.skyblue : AppColors.gray3,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// web `TopicsRecommendation.tsx`. 주제를 누르면 그 제목으로 리스트 작성을 시작한다.
class TopicsRecommendation extends ConsumerWidget {
  const TopicsRecommendation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(recommendedTopicsProvider).value ?? const [];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(l10n.home_topicsTitle, style: context.typo.subtitle),
              const Spacer(),
              TextButton(
                onPressed: () => context.push(AppRoutes.topics),
                child: Text(
                  l10n.common_more,
                  style: context.typo.label.copyWith(color: AppColors.gray),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final topic in topics)
                ActionChip(
                  label: Text(topic.title),
                  labelStyle: context.typo.label.copyWith(
                    color: AppColors.black,
                  ),
                  backgroundColor: AppColors.white,
                  side: const BorderSide(color: AppColors.skyblue),
                  shape: const StadiumBorder(),
                  onPressed: () => context.push(
                    Uri(
                      path: AppRoutes.listCreate,
                      queryParameters: {'title': topic.title},
                    ).toString(),
                  ),
                ),
              ActionChip(
                label: Text(l10n.home_requestTopic),
                labelStyle: context.typo.labelBold.copyWith(
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.blue,
                side: BorderSide.none,
                shape: const StadiumBorder(),
                onPressed: () => context.push(AppRoutes.topics),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// web `RecommendedUsers.tsx`. 팔로우 버튼은 M3 (쓰기) 에서 붙인다.
class UsersRecommendation extends ConsumerWidget {
  const UsersRecommendation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final users = ref.watch(recommendedUsersProvider);
    final List<UserProfileType> items;
    if (users.isLoading && !users.hasValue) {
      items = [
        for (var i = 0; i < 3; i++)
          UserProfileType(id: i, profileImageUrl: null, nickname: 'nickname'),
      ];
    } else {
      items = users.value ?? const [];
    }
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.home_recommendedUsers,
              style: context.typo.subtitle,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: Skeletonizer(
              enabled: !users.hasValue,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final user = items[index];
                  return GestureDetector(
                    onTap: () => context.push(AppRoutes.myList('${user.id}')),
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          UserProfileImage(
                            src: user.profileImageUrl,
                            size: 80,
                            semanticLabel:
                                l10n.common_recommendUserProfileImage,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.nickname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.typo.labelBold,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
