import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/comment_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/infinite_scroll.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../application/list_detail_providers.dart';

/// web 리스트 상세의 전체 댓글 bottom sheet (`Comments.tsx`). 작성/수정/삭제는 M3 에서 붙인다.
Future<void> showCommentsSheet(BuildContext context, {required int listId}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        builder: (context, controller) =>
            CommentsSheet(listId: listId, scrollController: controller),
      ),
    );

class CommentsSheet extends ConsumerWidget {
  const CommentsSheet({
    super.key,
    required this.listId,
    required this.scrollController,
  });

  final int listId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = commentsProvider(listId);
    final state = ref.watch(provider);
    final page = state.value;

    final List<Widget> slivers;
    if (page == null && state.hasError) {
      slivers = [
        SliverToBoxAdapter(
          child: ErrorView(
            error: state.error!,
            onRetry: () => ref.invalidate(provider),
          ),
        ),
      ];
    } else if (page == null) {
      slivers = [
        SliverToBoxAdapter(
          child: Skeletonizer(
            child: Column(
              children: [
                for (var i = 0; i < 3; i++) CommentTile(comment: _skeleton),
              ],
            ),
          ),
        ),
      ];
    } else {
      slivers = [
        SliverList.builder(
          itemCount: page.items.length,
          itemBuilder: (context, index) =>
              CommentTile(comment: page.items[index]),
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
            child: ErrorView(
              error: page.loadMoreError!,
              onRetry: () => ref.read(provider.notifier).loadMore(),
            ),
          ),
      ];
    }

    return InfiniteScroll(
      canLoadMore:
          page != null &&
          page.hasNext &&
          !page.isLoadingMore &&
          page.loadMoreError == null,
      onLoadMore: () => ref.read(provider.notifier).loadMore(),
      child: CustomScrollView(
        key: const Key('comments.list'),
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Text(l10n.comment_comment, style: context.typo.subtitle),
                  const SizedBox(width: 6),
                  Text(
                    l10n.comment_count(page?.totalCount ?? 0),
                    style: context.typo.label.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverMainAxisGroup(slivers: slivers),
          ),
        ],
      ),
    );
  }
}

const _skeleton = CommentType(
  id: 0,
  userId: 0,
  userNickname: 'nickname',
  userProfileImageUrl: null,
  content: 'skeleton comment content',
  createdDate: '2024-01-01T00:00:00',
  updatedDate: '2024-01-01T00:00:00',
  isDeleted: false,
  replies: [],
  mentions: [],
);

/// web `Comment.tsx` + `Replies.tsx`. 답글은 "N개의 답글 더보기" 를 눌러야 펼친다.
class CommentTile extends StatefulWidget {
  const CommentTile({super.key, required this.comment});

  final CommentType comment;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool _repliesOpened = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = widget.comment;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentBody(
            userId: c.isDeleted ? null : c.userId,
            nickname: c.isDeleted ? l10n.comment_unknown : c.userNickname,
            profileImageUrl: c.isDeleted ? null : c.userProfileImageUrl,
            date: c.updatedDate,
            content: c.isDeleted ? l10n.comment_deletedMessage : c.content,
            isDeleted: c.isDeleted,
            imageSize: 30,
          ),
          if (c.replies.isNotEmpty && !_repliesOpened)
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 8, 0, 0),
              child: GestureDetector(
                key: Key('comment.${c.id}.showReplies'),
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _repliesOpened = true),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 20, height: 1, color: AppColors.lightgray),
                    const SizedBox(width: 6),
                    Text(
                      l10n.comment_moreReply(c.replies.length),
                      style: context.typo.labelSmall.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_repliesOpened)
            for (final reply in c.replies)
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 12, 0, 0),
                child: _CommentBody(
                  userId: reply.userId,
                  nickname: reply.userNickname,
                  profileImageUrl: reply.userProfileImageUrl,
                  date: reply.updatedDate,
                  content: reply.content,
                  isDeleted: false,
                  imageSize: 20,
                ),
              ),
        ],
      ),
    );
  }
}

class _CommentBody extends StatelessWidget {
  const _CommentBody({
    required this.userId,
    required this.nickname,
    required this.profileImageUrl,
    required this.date,
    required this.content,
    required this.isDeleted,
    required this.imageSize,
  });

  /// 탈퇴/삭제된 댓글이면 null (프로필로 이동하지 않는다).
  final int? userId;
  final String nickname;
  final String? profileImageUrl;
  final String date;
  final String content;
  final bool isDeleted;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    void openProfile() {
      final id = userId;
      if (id != null) context.push(AppRoutes.myList('$id'));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: openProfile,
          child: UserProfileImage(
            src: profileImageUrl,
            size: imageSize,
            semanticLabel: l10n.comment_profileImageAlt,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: openProfile,
                    child: Text(nickname, style: context.typo.labelBold),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    timeDiff(date, l10n),
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: isDeleted
                    ? context.typo.label.copyWith(color: AppColors.gray)
                    : context.typo.label.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
