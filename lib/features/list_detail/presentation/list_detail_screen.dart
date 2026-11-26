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
import '../../../core/widgets/user_profile_image.dart';
import '../application/list_detail_providers.dart';
import 'widgets/collaborators.dart';
import 'widgets/comments_sheet.dart';
import 'widgets/newest_comment_preview.dart';
import 'widgets/rank_list.dart';

/// web `src/app/list/[listId]` (ListInformation + ListDetailInner) 의 읽기 부분.
/// 리액션/콜렉트/공유/더보기 footer 와 관리 메뉴는 M3 에서 붙인다.
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
          const SizedBox(height: 24),
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
