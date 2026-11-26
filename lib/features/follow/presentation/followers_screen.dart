import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../application/follow_providers.dart';
import 'widgets/user_list.dart';

/// web `/user/[userId]/followers`. 내 팔로워 목록이면 사용자마다 삭제 버튼이 있다.
class FollowersScreen extends ConsumerWidget {
  const FollowersScreen({super.key, required this.userId});

  final String userId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    int listOwnerId,
    int followerId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.user_deleteFollowerConfirm,
      confirmLabel: l10n.common_delete,
    );
    if (!confirmed) return;
    try {
      await ref
          .read(followerListProvider(listOwnerId).notifier)
          .removeFollower(followerId);
    } on Exception {
      if (context.mounted) showToast(context, l10n.toast_deleteFollowerError);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(userId);
    final state = id == null ? null : ref.watch(followerListProvider(id));
    final isMine = id != null && ref.watch(currentUserIdProvider) == id;
    return FollowUserListScaffold(
      title: l10n.user_follower,
      userId: userId,
      users: (
        users: state?.value?.followers,
        error: id == null ? ArgumentError.value(userId) : state?.error,
      ),
      emptyMessage: l10n.user_emptyFollower,
      onRetry: () {
        if (id != null) ref.invalidate(followerListProvider(id));
      },
      trailingBuilder: isMine
          ? (user) => TextButton(
              key: Key('follower.${user.id}.delete'),
              onPressed: () => _delete(context, ref, id, user.id),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.bggray,
                foregroundColor: AppColors.gray3,
              ),
              child: Text(l10n.common_delete),
            )
          : null,
    );
  }
}
