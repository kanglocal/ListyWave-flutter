import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/home_type.dart';
import '../../../../core/models/user_profile_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../../follow/presentation/widgets/follow_button.dart';
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
        height: 280,
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

/// web swiper: slide 260, 사이 20, 높이 280 (위아래 10), 가운데 정렬. 점 표시는 없다.
class _RecommendedSwiperState extends State<_RecommendedSwiper> {
  /// loop 를 위해 가운데에서 시작한다.
  static const _loopBase = 1000;
  static const _slide = 260.0;
  static const _gap = 20.0;

  PageController? _controller;
  double? _fraction;
  Timer? _autoplay;
  late int _page;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _page = widget.items.length * _loopBase;
    _autoplay = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      final controller = _controller;
      // 다른 화면에 가려져 있으면 (TickerMode off) 넘기지 않는다.
      if (controller == null || !controller.hasClients || !_visible) {
        return;
      }
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _autoplay?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  PageController _controllerFor(double width) {
    final fraction = ((_slide + _gap) / width).clamp(0.1, 1.0);
    if (_controller == null || _fraction != fraction) {
      _controller?.dispose();
      _fraction = fraction;
      _controller = PageController(
        initialPage: _page,
        viewportFraction: fraction,
      );
    }
    return _controller!;
  }

  @override
  Widget build(BuildContext context) {
    _visible = TickerMode.of(context);
    final count = widget.items.length;
    return SizedBox(
      height: 280,
      child: LayoutBuilder(
        builder: (context, constraints) => PageView.builder(
          key: const Key('home.recommendedSwiper'),
          controller: _controllerFor(constraints.maxWidth),
          onPageChanged: (page) => _page = page,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _gap / 2,
              vertical: 10,
            ),
            child: Center(
              child: SizedBox.square(
                dimension: _slide,
                child: _RecommendedListItem(item: widget.items[index % count]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// web RecommendedListsItem (`HomeRecommendedLists.css.ts`). 대표 이미지가 있으면 원형 이미지에
/// 30% 검정을 덮고, 없으면 radius 38 흰 사각형이다.
class _RecommendedListItem extends StatelessWidget {
  const _RecommendedListItem({required this.item});

  final HomeRecommendedListType item;

  @override
  Widget build(BuildContext context) {
    final hasImage = item.itemImageUrl?.isNotEmpty ?? false;
    final textColor = hasImage ? AppColors.white : AppColors.black;
    final radius = hasImage ? 130.0 : 38.0;
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
                const ColoredBox(color: Color(0x4D000000)),
              ] else
                const ColoredBox(color: AppColors.white),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                // 정사각형 카드라 글자가 커지면 (접근성 글자 크기) 넘치는 대신 내용 전체를 줄인다.
                child: LayoutBuilder(
                  builder: (context, constraints) => FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.category,
                              style: context.typo.label.copyWith(
                                letterSpacing: 0,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.typo.subtitle.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.ownerNickname,
                            style: context.typo.bodyRegular.copyWith(
                              letterSpacing: -0.48,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          for (final (index, top) in item.items.indexed)
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                index == 0 ? 0 : 7,
                                0,
                                0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: hasImage
                                      ? const Color(0x4DF5FAFF)
                                      : const Color(0xFFF5FAFF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${index + 1}. ${top.title}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.typo.label.copyWith(
                                    fontSize: 10,
                                    letterSpacing: 0,
                                    color: hasImage
                                        ? AppColors.white
                                        : AppColors.blue,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// web `TopicsRecommendation.tsx` (`TopicsRecommendation.css.ts`). 주제를 누르면 그 제목으로
/// 리스트 작성을 시작한다. 주제는 가로 한 줄로 흐르고 끝에 "주제 요청하기→" 가 붙는다.
class TopicsRecommendation extends ConsumerWidget {
  const TopicsRecommendation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(recommendedTopicsProvider).value ?? const [];
    final chipStyle = context.typo.body.copyWith(
      letterSpacing: -0.45,
      color: const Color(0xFF292929),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.home_topicsTitle,
                    style: context.typo.subtitle.copyWith(
                      letterSpacing: 0,
                      color: AppColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.topics),
                  child: Text(
                    l10n.common_more,
                    style: context.typo.label.copyWith(
                      letterSpacing: 0,
                      color: AppColors.bluegray10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                for (final topic in topics) ...[
                  _TopicPill(
                    label: topic.title,
                    style: chipStyle,
                    onTap: () => context.push(
                      Uri(
                        path: AppRoutes.listCreate,
                        queryParameters: {'title': topic.title},
                      ).toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                _TopicPill(
                  label: l10n.home_requestTopic,
                  style: chipStyle.copyWith(color: AppColors.white),
                  background: AppColors.blue,
                  onTap: () => context.push(AppRoutes.topics),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// web topic: padding 14, radius 20, 흰 바탕.
class _TopicPill extends StatelessWidget {
  const _TopicPill({
    required this.label,
    required this.style,
    required this.onTap,
    this.background = AppColors.white,
  });

  final String label;
  final TextStyle style;
  final VoidCallback onTap;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    return Material(
      color: background,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Text(label, style: style),
        ),
      ),
    );
  }
}

/// web `RecommendedUsers.tsx` (`RecommendedUsers.css.ts`). 카드 없이 122 원형 사진, 닉네임,
/// 팔로우 버튼을 가로로 늘어놓는다. backend 가 이미 팔로우한 사람을 빼고 주므로 처음엔 팔로우다.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            l10n.home_recommendedUsers,
            style: context.typo.subtitle.copyWith(
              letterSpacing: 0,
              color: AppColors.black,
            ),
          ),
        ),
        Skeletonizer(
          enabled: !users.hasValue,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (i, user) in items.indexed) ...[
                  if (i > 0) const SizedBox(width: 20),
                  SizedBox(
                    width: 122,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              context.push(AppRoutes.myList('${user.id}')),
                          child: UserProfileImage(
                            src: user.profileImageUrl,
                            size: 122,
                            semanticLabel:
                                l10n.common_recommendUserProfileImage,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.nickname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: context.typo.label.copyWith(
                            letterSpacing: -0.28,
                            color: const Color(0xFF121417),
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (users.hasValue)
                          FollowButton(userId: user.id, isFollowed: false),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
