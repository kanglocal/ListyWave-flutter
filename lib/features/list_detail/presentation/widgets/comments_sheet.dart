import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router.dart';
import '../../../../core/auth/current_user.dart';
import '../../../../core/auth/require_login.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/comment_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/infinite_scroll.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../application/list_detail_providers.dart';

/// web 리스트 상세의 전체 댓글 bottom sheet (`Comments.tsx` + `CommentForm.tsx`).
Future<void> showCommentsSheet(BuildContext context, {required int listId}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => Padding(
        // 키보드가 올라오면 입력창이 가려지지 않게 올린다.
        padding: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          maxChildSize: 0.95,
          builder: (context, controller) =>
              CommentsSheet(listId: listId, scrollController: controller),
        ),
      ),
    );

/// 댓글 입력창이 지금 하는 일. web `useComment` store (status, commentId, replyId) 를 합친 것.
sealed class _ComposerMode {
  const _ComposerMode();
}

class _NewComment extends _ComposerMode {
  const _NewComment();
}

class _NewReply extends _ComposerMode {
  const _NewReply(this.comment, this.nickname);

  final CommentType comment;

  /// 답글 대상 표시 (`@nickname 님에게 남긴 답글`).
  final String nickname;
}

class _EditComment extends _ComposerMode {
  const _EditComment(this.comment);

  final CommentType comment;
}

class _EditReply extends _ComposerMode {
  const _EditReply(this.reply);

  final ReplyType reply;
}

/// 댓글/답글 하나에 대한 동작 (작성자 본인만 수정/삭제).
class CommentActions {
  const CommentActions({
    required this.currentUserId,
    required this.onReply,
    required this.onEditComment,
    required this.onDeleteComment,
    required this.onEditReply,
    required this.onDeleteReply,
  });

  final int? currentUserId;

  /// 댓글에 답글 달기. 답글의 답글이면 [reply] 의 작성자를 멘션한다.
  final void Function(CommentType comment, ReplyType? reply) onReply;
  final void Function(CommentType comment) onEditComment;
  final void Function(CommentType comment) onDeleteComment;
  final void Function(ReplyType reply) onEditReply;
  final void Function(ReplyType reply) onDeleteReply;
}

class CommentsSheet extends ConsumerStatefulWidget {
  const CommentsSheet({
    super.key,
    required this.listId,
    required this.scrollController,
  });

  final int listId;
  final ScrollController scrollController;

  @override
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  _ComposerMode _mode = const _NewComment();

  /// 멘션 후보 (userId → nickname). 보낼 때 내용에 `@nickname` 이 남아 있는 사람만 보낸다.
  Map<int, String> _mentionCandidates = {};
  bool _sending = false;

  /// 이 댓글은 답글을 펼친 채로 둔다 (답글을 달거나 고친 뒤).
  final Set<int> _openedReplies = {};

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  CommentsNotifier get _notifier =>
      ref.read(commentsProvider(widget.listId).notifier);

  void _setMode(
    _ComposerMode mode, {
    String text = '',
    Map<int, String> mentions = const {},
  }) {
    setState(() {
      _mode = mode;
      _mentionCandidates = {...mentions};
    });
    _controller
      ..text = text
      ..selection = TextSelection.collapsed(offset: text.length);
    if (mode is! _NewComment) _focusNode.requestFocus();
  }

  void _reset() => _setMode(const _NewComment());

  List<int> _mentionIds(String content) => [
    for (final MapEntry(key: id, value: nickname) in _mentionCandidates.entries)
      if (content.contains('@$nickname')) id,
  ];

  Future<void> _submit() async {
    final content = _controller.text.trim();
    if (content.isEmpty || _sending) return;
    if (requireLogin(context) == null) return;
    final l10n = AppLocalizations.of(context);
    final mentions = _mentionIds(content);
    setState(() => _sending = true);
    try {
      switch (_mode) {
        case _NewComment():
          await _notifier.createComment(content, mentions);
        case _NewReply(:final comment):
          await _notifier.createReply(comment.id, content, mentions);
          _openedReplies.add(comment.id);
        case _EditComment(:final comment):
          await _notifier.updateComment(comment.id, content, mentions);
        case _EditReply(:final reply):
          await _notifier.updateReply(
            reply.commentId,
            reply.id,
            content,
            mentions,
          );
          _openedReplies.add(reply.commentId);
      }
      if (mounted) _reset();
    } on Exception {
      if (mounted) showToast(context, l10n.toast_commentFailed);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _delete(Future<void> Function() request) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.comment_deleteConfirm,
      confirmLabel: l10n.common_delete,
    );
    if (!confirmed) return;
    try {
      await request();
    } on Exception {
      if (mounted) showToast(context, l10n.toast_commentFailed);
    }
  }

  void _onReply(CommentType comment, ReplyType? reply) {
    if (requireLogin(context) == null) return;
    final me = ref.read(currentUserIdProvider);
    // 답글의 답글은 그 답글 작성자를 멘션한다 (backend `mentionIds`).
    if (reply != null && reply.userId != me) {
      _setMode(
        _NewReply(comment, reply.userNickname),
        text: '@${reply.userNickname} ',
        mentions: {reply.userId: reply.userNickname},
      );
    } else {
      _setMode(_NewReply(comment, comment.userNickname));
    }
  }

  void _onEditComment(CommentType comment) => _setMode(
    _EditComment(comment),
    text: comment.content,
    mentions: {for (final m in comment.mentions) m.userId: m.userNickname},
  );

  void _onEditReply(ReplyType reply) => _setMode(
    _EditReply(reply),
    text: reply.content,
    mentions: {for (final m in reply.mentions) m.userId: m.userNickname},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = commentsProvider(widget.listId);
    final state = ref.watch(provider);
    final page = state.value;
    final userId = ref.watch(currentUserIdProvider);
    final actions = CommentActions(
      currentUserId: userId,
      onReply: _onReply,
      onEditComment: _onEditComment,
      onDeleteComment: (c) => _delete(() => _notifier.deleteComment(c.id)),
      onEditReply: _onEditReply,
      onDeleteReply: (r) =>
          _delete(() => _notifier.deleteReply(r.commentId, r.id)),
    );

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
                for (var i = 0; i < 3; i++)
                  const CommentTile(comment: _skeleton),
              ],
            ),
          ),
        ),
      ];
    } else {
      slivers = [
        SliverList.builder(
          itemCount: page.items.length,
          itemBuilder: (context, index) {
            final comment = page.items[index];
            return CommentTile(
              key: ValueKey('comment.${comment.id}'),
              comment: comment,
              actions: actions,
              initiallyOpened: _openedReplies.contains(comment.id),
            );
          },
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

    return Column(
      children: [
        Expanded(
          child: InfiniteScroll(
            canLoadMore:
                page != null &&
                page.hasNext &&
                !page.isLoadingMore &&
                page.loadMoreError == null,
            onLoadMore: () => ref.read(provider.notifier).loadMore(),
            child: CustomScrollView(
              key: const Key('comments.list'),
              controller: widget.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Row(
                      children: [
                        Text(
                          l10n.comment_comment,
                          style: context.typo.subtitle,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.comment_count(page?.totalCount ?? 0),
                          style: context.typo.label.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverMainAxisGroup(slivers: slivers),
                ),
              ],
            ),
          ),
        ),
        _Composer(
          controller: _controller,
          focusNode: _focusNode,
          mode: _mode,
          isLoggedIn: userId != null,
          sending: _sending,
          onSubmit: _submit,
          onCancel: _reset,
        ),
      ],
    );
  }
}

/// web `CommentForm.tsx`. 비로그인이면 읽기 전용이고 누르면 로그인 sheet 를 띄운다.
class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.mode,
    required this.isLoggedIn,
    required this.sending,
    required this.onSubmit,
    required this.onCancel,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final _ComposerMode mode;
  final bool isLoggedIn;
  final bool sending;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  /// backend `CommentContent.LENGTH_LIMIT`.
  static const maxLength = 500;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final banner = switch (mode) {
      _NewComment() => null,
      _NewReply(:final nickname) => l10n.comment_replyTo(nickname),
      _EditComment() || _EditReply() => l10n.comment_editing,
    };
    return Material(
      color: AppColors.white,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (banner != null)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        banner,
                        key: const Key('comments.composerBanner'),
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.gray,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const Key('comments.cancelMode'),
                      tooltip: l10n.comment_cancelButtonAlt,
                      visualDensity: VisualDensity.compact,
                      onPressed: onCancel,
                      icon: SvgPicture.asset(
                        'assets/icons/cancel_button.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('comments.input'),
                      controller: controller,
                      focusNode: focusNode,
                      readOnly: !isLoggedIn,
                      onTap: isLoggedIn ? null : () => requireLogin(context),
                      minLines: 1,
                      maxLines: 4,
                      maxLength: maxLength,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                        hintText: isLoggedIn
                            ? l10n.comment_placeholder
                            : l10n.comment_placeholderLogin,
                      ),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: controller,
                    builder: (context, _) => IconButton(
                      key: const Key('comments.send'),
                      tooltip: l10n.comment_send,
                      onPressed: sending || controller.text.trim().isEmpty
                          ? null
                          : onSubmit,
                      icon: SvgPicture.asset(
                        'assets/icons/airplane_send.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.blue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
  const CommentTile({
    super.key,
    required this.comment,
    this.actions,
    this.initiallyOpened = false,
  });

  final CommentType comment;

  /// null 이면 (skeleton) 버튼을 보이지 않는다.
  final CommentActions? actions;
  final bool initiallyOpened;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  late bool _repliesOpened = widget.initiallyOpened;

  @override
  void didUpdateWidget(CommentTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initiallyOpened) _repliesOpened = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = widget.comment;
    final actions = widget.actions;
    final me = actions?.currentUserId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentBody(
            keyPrefix: 'comment.${c.id}',
            userId: c.isDeleted ? null : c.userId,
            nickname: c.isDeleted ? l10n.comment_unknown : c.userNickname,
            profileImageUrl: c.isDeleted ? null : c.userProfileImageUrl,
            date: c.updatedDate,
            content: c.isDeleted ? l10n.comment_deletedMessage : c.content,
            isDeleted: c.isDeleted,
            imageSize: 30,
            onReply: actions == null || c.isDeleted
                ? null
                : () => actions.onReply(c, null),
            onEdit: actions != null && !c.isDeleted && c.userId == me
                ? () => actions.onEditComment(c)
                : null,
            onDelete: actions != null && !c.isDeleted && c.userId == me
                ? () => actions.onDeleteComment(c)
                : null,
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
                  keyPrefix: 'reply.${reply.id}',
                  userId: reply.userId,
                  nickname: reply.userNickname,
                  profileImageUrl: reply.userProfileImageUrl,
                  date: reply.updatedDate,
                  content: reply.content,
                  isDeleted: false,
                  imageSize: 20,
                  onReply: actions == null || c.isDeleted
                      ? null
                      : () => actions.onReply(c, reply),
                  onEdit: actions != null && reply.userId == me
                      ? () => actions.onEditReply(reply)
                      : null,
                  onDelete: actions != null && reply.userId == me
                      ? () => actions.onDeleteReply(reply)
                      : null,
                ),
              ),
        ],
      ),
    );
  }
}

class _CommentBody extends StatelessWidget {
  const _CommentBody({
    required this.keyPrefix,
    required this.userId,
    required this.nickname,
    required this.profileImageUrl,
    required this.date,
    required this.content,
    required this.isDeleted,
    required this.imageSize,
    this.onReply,
    this.onEdit,
    this.onDelete,
  });

  final String keyPrefix;

  /// 탈퇴/삭제된 댓글이면 null (프로필로 이동하지 않는다).
  final int? userId;
  final String nickname;
  final String? profileImageUrl;
  final String date;
  final String content;
  final bool isDeleted;
  final double imageSize;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    void openProfile() {
      final id = userId;
      if (id != null) context.push(AppRoutes.myList('$id'));
    }

    final actionStyle = context.typo.labelSmall.copyWith(color: AppColors.gray);
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
              if (onReply != null || onEdit != null || onDelete != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Wrap(
                    spacing: 12,
                    children: [
                      if (onReply != null)
                        GestureDetector(
                          key: Key('$keyPrefix.reply'),
                          onTap: onReply,
                          child: Text(l10n.comment_reply, style: actionStyle),
                        ),
                      if (onEdit != null)
                        GestureDetector(
                          key: Key('$keyPrefix.edit'),
                          onTap: onEdit,
                          child: Text(l10n.comment_edit, style: actionStyle),
                        ),
                      if (onDelete != null)
                        GestureDetector(
                          key: Key('$keyPrefix.delete'),
                          onTap: onDelete,
                          child: Text(l10n.common_delete, style: actionStyle),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
