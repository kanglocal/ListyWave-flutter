import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/gen/app_localizations.dart';
import '../application/follow_providers.dart';
import 'widgets/user_list.dart';

/// web `/user/[userId]/followers`.
class FollowersScreen extends ConsumerWidget {
  const FollowersScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(userId);
    final state = id == null ? null : ref.watch(followerListProvider(id));
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
    );
  }
}
