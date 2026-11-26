import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/gen/app_localizations.dart';
import '../application/follow_providers.dart';
import 'widgets/user_list.dart';

/// web `/user/[userId]/followings`.
class FollowingsScreen extends ConsumerWidget {
  const FollowingsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(userId);
    final state = id == null ? null : ref.watch(followingListProvider(id));
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
    );
  }
}
