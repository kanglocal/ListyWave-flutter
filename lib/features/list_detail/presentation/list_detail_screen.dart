import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/list_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
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
    if (detail == null || (detail.hasError && list == null)) {
      // web 은 조회 실패를 "삭제 또는 비공개" 모달로 안내하고 홈으로 보낸다.
      body = NoDataView(
        message: l10n.listDetail_deletedOrPrivate,
        buttonLabel: l10n.common_confirm,
        onButtonPressed: () => context.go(AppRoutes.home),
      );
    } else if (list == null) {
      body = Skeletonizer(
        child: _ListContent(list: _skeletonList, listId: 0, isOwner: false),
      );
    } else if (isHidden) {
      body = NoDataView(message: l10n.listDetail_privateMessage);
    } else {
      body = _ListContent(list: list, listId: id!, isOwner: isOwner);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.listDetail_title, style: context.typo.bodyBold),
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () => context.push(AppRoutes.myList('${list.ownerId}')),
                child: Row(
                  children: [
                    UserProfileImage(
                      src: list.ownerProfileImageUrl,
                      size: 36,
                      semanticLabel: l10n.listDetail_profileImageAlt,
                    ),
                    const SizedBox(width: 8),
                    Text(list.ownerNickname, style: context.typo.bodyBold),
                  ],
                ),
              ),
              const Spacer(),
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
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    LabelChip(
                      text: list.categoryKorName,
                      type: LabelChipType.skyblue,
                      onTap: () => context.push(
                        Uri(
                          path: AppRoutes.search,
                          queryParameters: {'categoryCode': list.categoryCode},
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
                Row(
                  children: [
                    if (!list.isPublic)
                      SvgPicture.asset(
                        'assets/icons/new/lock.svg',
                        width: 20,
                        height: 20,
                      ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      'assets/icons/ver3/visibility.svg',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 2),
                    Text('${list.viewCount}', style: context.typo.label),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(list.title, style: context.typo.header),
          if (list.description?.isNotEmpty ?? false) ...[
            const SizedBox(height: 6),
            Text(
              list.description!,
              style: context.typo.body.copyWith(color: AppColors.gray3),
            ),
          ],
          const SizedBox(height: 16),
          RankListSection(list: list),
          if (listId != 0)
            ListFooter(list: list, listId: listId, isOwner: isOwner),
          const SizedBox(height: 12),
          _CommentsCard(list: list, listId: listId),
        ],
      ),
    );
  }
}

/// web "댓글 카드": 최신 댓글 하나를 보이고, 누르면 전체 댓글 bottom sheet 를 연다.
class _CommentsCard extends StatelessWidget {
  const _CommentsCard({required this.list, required this.listId});

  final ListDetailType list;
  final int listId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      child: InkWell(
        key: const Key('listDetail.comments'),
        borderRadius: BorderRadius.circular(16),
        onTap: () => showCommentsSheet(context, listId: listId),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bggray,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(l10n.comment_comment, style: context.typo.bodyBold),
                  const SizedBox(width: 6),
                  Text(
                    l10n.comment_count(list.totalCommentCount),
                    style: context.typo.label.copyWith(color: AppColors.gray),
                  ),
                  const Spacer(),
                  Text(
                    l10n.common_more,
                    style: context.typo.label.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              NewestCommentPreview(comment: list.newestComment),
            ],
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
