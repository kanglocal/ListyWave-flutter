import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../application/follow_providers.dart';
import 'widgets/follow_button.dart';
import 'widgets/user_list.dart';

/// web `/user/[userId]/followings`. 내 팔로잉 목록이면 모두 팔로우 중이므로 팔로잉 버튼으로
/// 바로 취소할 수 있다 (다른 사람 목록은 backend 가 내 팔로우 여부를 주지 않아 버튼이 없다).
class FollowingsScreen extends ConsumerWidget {
  const FollowingsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(userId);
    final state = id == null ? null : ref.watch(followingListProvider(id));
    final isMine = id != null && ref.watch(currentUserIdProvider) == id;
    return FollowUserListScaffold(
      title: l10n.user_following,
      userId: userId,
      users: (
        users: state?.value?.followings,
        error: id == null ? ArgumentError.value(userId) : state?.error,
      ),
      emptyMessage: l10n.user_emptyFollowing,
      onRetry: () {
        if (id != null) ref.invalidate(followingListProvider(id));
      },
      trailingBuilder: isMine
          ? (user) => FollowButton(userId: user.id, isFollowed: true)
          : null,
    );
  }
}
