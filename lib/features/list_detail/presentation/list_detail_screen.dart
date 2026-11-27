import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/list_type.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/label_chip.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../../core/widgets/user_profile_image.dart';
import '../../follow/presentation/widgets/follow_button.dart';
import '../application/list_detail_providers.dart';
import 'widgets/collaborators.dart';
import 'widgets/comments_sheet.dart';
import 'widgets/list_footer.dart';
import 'widgets/list_option_sheets.dart';
import 'widgets/newest_comment_preview.dart';
import 'widgets/rank_list.dart';
import '../../../core/widgets/listy_header.dart';

/// web `src/app/list/[listId]` (ListInformation + ListDetailInner).
/// footer (리액션/콜렉트/공유/더보기) 와 주인 관리 메뉴 (`OpenBottomSheetButton.tsx`) 가 있다.
class ListDetailScreen extends ConsumerWidget {
  const ListDetailScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(listId);
    final detail = id == null ? null : ref.watch(listDetailProvider(id));
    final userId = ref.watch(currentUserIdProvider);
    final list = detail?.value;
    final isOwner = list != null && list.ownerId == userId;
    final isCollaborator =
        list != null &&
        userId != null &&
        !isOwner &&
        list.collaborators.any((c) => c.id == userId);
    final isHidden =
        list != null && !list.isPublic && !isOwner && !isCollaborator;

    final Widget body;
    final error = detail != null && list == null ? detail.error : null;
    final errorStatus = error == null ? null : AppException.from(error).status;
    if (error != null && (errorStatus == null || errorStatus >= 500)) {
      // 응답을 못 받았거나 서버 오류면 리스트가 없는 것이 아니므로 다른 조회 화면처럼
      // 다시 시도할 수 있게 한다.
      body = Center(
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(listDetailProvider(id!)),
        ),
      );
    } else if (detail == null || error != null) {
      // web 은 조회 실패를 "삭제 또는 비공개" 모달로 안내하고 홈으로 보낸다.
      body = NoDataView(
        message: l10n.listDetail_deletedOrPrivate,
        buttonLabel: l10n.common_confirm,
        onButtonPressed: () => context.go(AppRoutes.home),
      );
    } else if (list == null) {
      body = const Skeletonizer(
        child: _ListContent(list: _skeletonList, listId: 0, isOwner: false),
      );
    } else if (isHidden) {
      body = NoDataView(message: l10n.listDetail_privateMessage);
    } else {
      body = _ListContent(list: list, listId: id!, isOwner: isOwner);
    }

    return Scaffold(
      appBar: ListyHeader(
        title: l10n.listDetail_title,
        actions: [
          if (list != null && !isHidden)
            IconButton(
              tooltip: l10n.listDetail_history,
              onPressed: () => context.push(AppRoutes.listHistory(listId)),
              icon: SvgPicture.asset('assets/icons/new/history.svg'),
            ),
          if (isOwner)
            IconButton(
              key: const Key('listDetail.ownerMenu'),
              tooltip: l10n.listDetail_manageList,
              onPressed: () => _showOwnerMenu(context, ref, list, id!),
              icon: SvgPicture.asset(
                'assets/icons/new/vertical_kebab_button.svg',
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (id == null) return;
          ref.invalidate(listDetailProvider(id));
          await ref.read(listDetailProvider(id).future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
          child: body,
        ),
      ),
    );
  }
}

/// 주인 관리 메뉴: 수정하기, 공개/비공개 전환, 삭제하기 (web `OpenBottomSheetButton.tsx`,
/// `OptionToggleButton.tsx`).
void _showOwnerMenu(
  BuildContext context,
  WidgetRef ref,
  ListDetailType list,
  int listId,
) {
  final l10n = AppLocalizations.of(context);
  final notifier = ref.read(listDetailProvider(listId).notifier);

  Future<void> toggleVisibility() async {
    try {
      await notifier.toggleVisibility();
      if (context.mounted) {
        showToast(context, l10n.toast_visibilityListSuccess);
      }
    } on Exception {
      if (context.mounted) showToast(context, l10n.toast_visibilityListError);
    }
  }

  Future<void> delete() async {
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.listDetail_deleteListConfirm,
      description: l10n.listDetail_deleteListDescription,
      confirmLabel: l10n.common_delete,
    );
    if (!confirmed || !context.mounted) return;
    final router = GoRouter.of(context);
    final me = ref.read(currentUserIdProvider);
    try {
      await notifier.delete();
      if (!context.mounted) return;
      showToast(context, l10n.toast_deleteListSuccess);
      // web 과 같이 내 마이리스트로 간다.
      router.go(me == null ? AppRoutes.home : AppRoutes.myList('$me'));
    } on Exception {
      if (context.mounted) showToast(context, l10n.toast_deleteListError);
    }
  }

  showOptionSheet(context, [
    SheetOption(
      key: const Key('owner.edit'),
      title: l10n.listDetail_editList,
      onTap: () => context.push(AppRoutes.listEdit('$listId')),
    ),
    SheetOption(
      key: const Key('owner.visibility'),
      title: list.isPublic
          ? l10n.listDetail_makePrivate
          : l10n.listDetail_makePublic,
      onTap: toggleVisibility,
    ),
    SheetOption(
      key: const Key('owner.delete'),
      title: l10n.listDetail_deleteList,
      color: AppColors.red,
      onTap: delete,
    ),
  ]);
}

class _ListContent extends StatelessWidget {
  const _ListContent({
    required this.list,
    required this.listId,
    required this.isOwner,
  });

  final ListDetailType list;
  final int listId;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final collaborators = list.collaborators
        .where((c) => c.id != list.ownerId)
        .toList();
    // web 3.0 `ListInformation.css.ts`: container padding 16, gap 20. 리스트 정보는 흰 카드
    // (padding 24, radius 20, gap 12), 댓글은 따로 흰 카드다.
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WhiteCard(
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
                              context.push(AppRoutes.myList('${list.ownerId}')),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UserProfileImage(
                                src: list.ownerProfileImageUrl,
                                size: 30,
                                semanticLabel: l10n.listDetail_profileImageAlt,
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  list.ownerNickname,
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
                    if (collaborators.isNotEmpty)
                      Collaborators(collaborators: collaborators),
                    if (!isOwner && listId != 0) ...[
                      const SizedBox(width: 8),
                      FollowButton(
                        userId: list.ownerId,
                        isFollowed: list.isFollowing,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          LabelChip(
                            text: list.categoryKorName,
                            type: LabelChipType.skyblue,
                            onTap: () => context.push(
                              Uri(
                                path: AppRoutes.search,
                                queryParameters: {
                                  'categoryCode': list.categoryCode,
                                },
                              ).toString(),
                            ),
                          ),
                          for (final label in list.labels)
                            LabelChip(
                              text: label.name,
                              type: LabelChipType.tag,
                              onTap: () => context.push(
                                Uri(
                                  path: AppRoutes.search,
                                  queryParameters: {'keyword': label.name},
                                ).toString(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (isOwner)
                      // listInfoWrapper: 사이 6, 조회수는 아이콘 아래에 숫자.
                      Row(
                        children: [
                          if (!list.isPublic) ...[
                            SvgPicture.asset(
                              'assets/icons/ver3/lock.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ver3/visibility.svg',
                                width: 20,
                                height: 20,
                              ),
                              Text(
                                '${list.viewCount}',
                                style: context.typo.label.copyWith(
                                  fontSize: 10,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  list.title,
                  style: context.typo.header.copyWith(color: AppColors.black),
                ),
                if (list.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 12),
                  Text(
                    list.description!,
                    style: context.typo.bodyRegular.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                RankListSection(list: list),
                if (listId != 0)
                  ListFooter(list: list, listId: listId, isOwner: isOwner),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _CommentsCard(list: list, listId: listId),
        ],
      ),
    );
  }
}

/// web 3.0 상세의 흰 카드 (padding 24, radius 20).
class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

/// web "댓글 카드" (`ListInformation.css.ts` commentsContainer: 흰색, padding 24, radius 20, gap 20).
/// 최신 댓글 하나를 보이고, 누르면 전체 댓글 bottom sheet 를 연다.
class _CommentsCard extends StatelessWidget {
  const _CommentsCard({required this.list, required this.listId});

  final ListDetailType list;
  final int listId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          key: const Key('listDetail.comments'),
          borderRadius: BorderRadius.circular(20),
          onTap: () => showCommentsSheet(context, listId: listId),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.comment_comment,
                      style: context.typo.bodyBold.copyWith(
                        letterSpacing: -0.48,
                        color: AppColors.black3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.comment_count(list.totalCommentCount),
                      style: context.typo.label.copyWith(
                        color: AppColors.gray3,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      l10n.common_more,
                      style: context.typo.label.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.39,
                        color: AppColors.black2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                NewestCommentPreview(comment: list.newestComment),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _skeletonList = ListDetailType(
  categoryCode: '0',
  categoryEngName: 'entire',
  categoryKorName: 'category',
  labels: [],
  title: 'skeleton list title',
  description: 'skeleton list description',
  createdDate: '2024-01-01T00:00:00',
  lastUpdatedDate: '2024-01-01T00:00:00',
  ownerId: 0,
  ownerNickname: 'nickname',
  ownerProfileImageUrl: null,
  collaborators: [],
  items: [
    ItemType(
      id: 1,
      rank: 1,
      title: 'first item',
      comment: null,
      link: null,
      imageUrl: null,
    ),
    ItemType(
      id: 2,
      rank: 2,
      title: 'second item',
      comment: null,
      link: null,
      imageUrl: null,
    ),
    ItemType(
      id: 3,
      rank: 3,
      title: 'third item',
      comment: null,
      link: null,
      imageUrl: null,
    ),
  ],
  isCollected: false,
  isPublic: true,
  isFollowing: false,
  backgroundPalette: 'PASTEL',
  backgroundColor: 'PASTEL_PINK',
  collectCount: null,
  viewCount: 0,
  updateCount: 0,
  totalCommentCount: 0,
  newestComment: null,
  reactions: [],
);
