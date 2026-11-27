import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/category/category_api.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/list_type.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/category_chips.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/floating_buttons.dart';
import '../../../core/widgets/infinite_scroll.dart';
import '../../../core/widgets/user_profile_image.dart';
import '../../follow/presentation/widgets/follow_button.dart';
import '../application/search_providers.dart';
import '../data/search_api.dart';
import 'widgets/top3_card.dart';
import '../../../core/widgets/listy_header.dart';

/// `/search?keyword=&categoryCode=&sort=` (web `src/app/search`).
/// 입력은 [debounce] 뒤에 검색하고, 엔터/검색 아이콘은 바로 검색한다 (web `useDebounce.ts`).
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.keyword, this.categoryCode, this.sort});

  final String? keyword;
  final String? categoryCode;
  final String? sort;

  static const debounce = Duration(milliseconds: 500);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _input;
  Timer? _debounce;
  late String _keyword;
  late String _categoryCode;

  /// 사용자가 고른 정렬. null 이면 keyword 에 따른 기본값을 쓴다.
  SearchSort? _sort;

  @override
  void initState() {
    super.initState();
    _keyword = (widget.keyword ?? '').trim();
    _input = TextEditingController(text: _keyword);
    final code = widget.categoryCode;
    _categoryCode = code == null || code.isEmpty ? entireCategoryCode : code;
    _sort = SearchSort.tryParse(widget.sort);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _input.dispose();
    super.dispose();
  }

  SearchSort get _effectiveSort {
    final sort = _sort;
    // 관련도순은 keyword 가 있을 때만 쓸 수 있다 (web SearchListResult.tsx).
    if (sort == null || !SearchSort.optionsFor(_keyword).contains(sort)) {
      return SearchSort.defaultFor(_keyword);
    }
    return sort;
  }

  void _submit(String value) {
    _debounce?.cancel();
    final keyword = value.trim();
    if (keyword == _keyword) return;
    setState(() => _keyword = keyword);
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(SearchScreen.debounce, () {
      if (mounted) _submit(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = (
      keyword: _keyword,
      sort: _effectiveSort,
      categoryCode: _categoryCode,
    );
    final listsProvider = searchListsProvider(query);
    final lists = ref.watch(listsProvider);
    final page = lists.value;
    final showUsers =
        _categoryCode == entireCategoryCode && _keyword.isNotEmpty;

    return Scaffold(
      appBar: ListyHeader(title: l10n.search_title),
      body: FloatingButtonsScope(
        sharePath: AppRoutes.search,
        bottom: 32,
        child: InfiniteScroll(
          canLoadMore:
              page != null &&
              page.hasNext &&
              !page.isLoadingMore &&
              page.loadMoreError == null,
          onLoadMore: () => ref.read(listsProvider.notifier).loadMore(),
          child: CustomScrollView(
            key: const Key('search.scroll'),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                  // web KeywordArea.css.ts: 흰 바탕 radius 12, 15px, padding 11 40 11 15.
                  child: TextField(
                    key: const Key('search.keyword'),
                    controller: _input,
                    textInputAction: TextInputAction.search,
                    onChanged: _onChanged,
                    onSubmitted: _submit,
                    style: context.typo.body.copyWith(
                      letterSpacing: 0,
                      color: AppColors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.search_placeholder,
                      hintStyle: context.typo.body.copyWith(
                        letterSpacing: 0,
                        color: AppColors.lightgray,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 11, 0, 11),
                      suffixIcon: IconButton(
                        tooltip: l10n.search_title,
                        onPressed: () => _submit(_input.text),
                        icon: SvgPicture.asset('assets/icons/ver3/search.svg'),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CategoryChips(
                  wrap: true,
                  spacing: 10,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  selectedCode: _categoryCode,
                  useEnglishName:
                      Localizations.localeOf(context).languageCode == 'en',
                  onSelected: (c) => setState(() => _categoryCode = c.code),
                ),
              ),
              if (showUsers)
                SliverToBoxAdapter(child: _UserResults(keyword: _keyword)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  // web SearchListResult.css.ts header: deepblue10, 제목 18/600, 개수 16/400.
                  child: Row(
                    children: [
                      Text(
                        l10n.search_listCountTitle,
                        style: _sectionTitle(context),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.search_listCount(page?.totalCount ?? 0),
                        style: _sectionCount(context),
                      ),
                      const Spacer(),
                      DropdownButton<SearchSort>(
                        key: const Key('search.sort'),
                        value: _effectiveSort,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(8),
                        dropdownColor: AppColors.white,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.black,
                          size: 20,
                        ),
                        style: context.typo.label.copyWith(
                          fontSize: 13,
                          letterSpacing: 0,
                          color: AppColors.black,
                        ),
                        items: [
                          for (final sort in SearchSort.optionsFor(_keyword))
                            DropdownMenuItem(
                              value: sort,
                              child: Text(_sortLabel(l10n, sort)),
                            ),
                        ],
                        onChanged: (sort) => setState(() => _sort = sort),
                      ),
                    ],
                  ),
                ),
              ),
              ..._listResults(
                context,
                lists,
                () => ref.invalidate(listsProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listResults(
    BuildContext context,
    AsyncValue<PageState<SearchListType, int>> state,
    VoidCallback onRetry,
  ) {
    final l10n = AppLocalizations.of(context);
    final page = state.value;
    if (page == null && state.hasError) {
      return [
        SliverToBoxAdapter(
          child: ErrorView(error: state.error!, onRetry: onRetry),
        ),
      ];
    }
    final List<SearchListType> items =
        page?.items ??
        [for (var i = 0; i < 6; i++) _skeletonList.copyWith(id: i)];
    if (page != null && items.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Column(
              children: [
                Text(l10n.search_noList, style: context.typo.bodyBold),
                if (_categoryCode != entireCategoryCode) ...[
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        setState(() => _categoryCode = entireCategoryCode),
                    child: Text(l10n.search_searchAllCategories),
                  ),
                ],
              ],
            ),
          ),
        ),
      ];
    }
    return [
      SliverPadding(
        // web cards: 2열, 사이 16 15, 아래 90.
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 15,
            mainAxisExtent: Top3Card.height,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => Skeletonizer(
            enabled: page == null,
            child: Top3Card(list: items[index]),
          ),
        ),
      ),
      if (page?.isLoadingMore ?? false)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ];
  }
}

TextStyle _sectionTitle(BuildContext context) => context.typo.subtitle.copyWith(
  fontWeight: FontWeight.w600,
  color: AppColors.deepblue10,
);

TextStyle _sectionCount(BuildContext context) => context.typo.bodyRegular
    .copyWith(letterSpacing: -0.48, color: AppColors.deepblue10);

String _sortLabel(AppLocalizations l10n, SearchSort sort) => switch (sort) {
  SearchSort.newest => l10n.search_sortNew,
  SearchSort.oldest => l10n.search_sortOld,
  SearchSort.related => l10n.search_sortRelated,
  SearchSort.collect => l10n.search_sortCollect,
};

const _skeletonList = SearchListType(
  id: 0,
  title: 'skeleton list',
  items: [
    ListItemInfoType(id: 1, title: 'first item'),
    ListItemInfoType(id: 2, title: 'second item'),
    ListItemInfoType(id: 3, title: 'third item'),
  ],
  isPublic: true,
  backgroundColor: 'PASTEL_SKYBLUE',
  updatedDate: '2024-01-01T00:00:00',
  ownerId: 0,
  ownerNickname: 'nickname',
  ownerProfileImageUrl: null,
  representImageUrl: null,
  categoryCode: '0',
  categoryKorName: 'category',
  categoryEngName: 'ENTIRE',
);

/// web `SearchUserResult.tsx`: 전체 카테고리에서 keyword 가 있을 때 리스터 결과를 가로로 보인다.
/// backend 가 사람마다 `isFollowing` 을 주므로 팔로우 버튼에 그대로 쓴다.
class _UserResults extends ConsumerWidget {
  const _UserResults({required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = searchUsersProvider(keyword);
    final state = ref.watch(provider);
    final page = state.value;
    if (page == null && state.hasError) {
      return ErrorView(
        error: state.error!,
        onRetry: () => ref.invalidate(provider),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Row(
            children: [
              Text(l10n.search_userCountTitle, style: _sectionTitle(context)),
              const SizedBox(width: 12),
              Text(
                l10n.search_userCount(page?.totalCount ?? 0),
                style: _sectionCount(context),
              ),
            ],
          ),
        ),
        if (page != null && page.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(l10n.search_noUser, style: context.typo.body),
          )
        else
          SizedBox(
            height: 225,
            child: InfiniteScroll(
              axis: Axis.horizontal,
              canLoadMore: page != null && page.hasNext && !page.isLoadingMore,
              onLoadMore: () => ref.read(provider.notifier).loadMore(),
              child: Skeletonizer(
                enabled: page == null,
                child: ListView.separated(
                  key: const Key('search.users'),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                  itemCount: page?.items.length ?? 3,
                  separatorBuilder: (_, _) => const SizedBox(width: 30),
                  itemBuilder: (context, index) {
                    final user = page?.items[index];
                    return GestureDetector(
                      onTap: user == null
                          ? null
                          : () => context.push(AppRoutes.myList('${user.id}')),
                      child: SizedBox(
                        width: 122,
                        child: Column(
                          children: [
                            // SearchUserProfile.css.ts: 122 원, 1px gray 테두리.
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.gray),
                              ),
                              child: UserProfileImage(
                                src: user?.profileImageUrl,
                                size: 120,
                                semanticLabel: l10n.user_profileImageAlt,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user?.nickname ?? 'nickname',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: context.typo.label.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            if (user != null) ...[
                              const SizedBox(height: 6),
                              FollowButton(
                                userId: user.id,
                                isFollowed: user.isFollowing,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
