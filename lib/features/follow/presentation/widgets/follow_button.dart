import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/current_user.dart';
import '../../../../core/auth/require_login.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/toast.dart';
import '../../../user/application/user_providers.dart';
import '../../application/follow_providers.dart';

/// web 팔로우 최대 수 (`toastMessage.ts` MAX_FOLLOWING).
const maxFollowing = 1000;

/// web `components/FollowButton` (목록용, 팔로우/팔로잉) 와
/// `user/[userId]/_components/FollowButton` (프로필용, 팔로우/팔로우 취소).
///
/// 서버 값 [isFollowed] 위에 [followControllerProvider] 의 낙관적 값을 덮어 보인다.
/// 비로그인이면 API 를 부르지 않고 로그인 sheet 를 띄운다. 내 자신에게는 보이지 않는다.
class FollowButton extends ConsumerWidget {
  const FollowButton({
    super.key,
    required this.userId,
    required this.isFollowed,
    this.profileStyle = false,
  });

  final int userId;
  final bool isFollowed;

  /// 프로필 헤더용 (팔로우 취소 문구, 흰 배경).
  final bool profileStyle;

  Future<void> _onPressed(
    BuildContext context,
    WidgetRef ref,
    bool following,
  ) async {
    final me = requireLogin(context);
    if (me == null) return;
    final l10n = AppLocalizations.of(context);
    if (!following) {
      final myFollowing = ref.read(userProvider(me)).value?.followingCount;
      if (myFollowing != null && myFollowing >= maxFollowing) {
        showToast(context, l10n.toast_limitFollow(maxFollowing));
        return;
      }
    }
    try {
      await ref
          .read(followControllerProvider.notifier)
          .toggle(userId, current: following);
    } on Exception {
      if (context.mounted) showToast(context, l10n.toast_followFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(currentUserIdProvider) == userId) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    final following = watchIsFollowing(ref, userId, serverValue: isFollowed);
    final label = following
        ? (profileStyle ? l10n.user_cancelFollow : l10n.common_following)
        : l10n.common_follow;
    final filled = !following;
    return SizedBox(
      height: 32,
      child: TextButton(
        key: Key('follow.$userId'),
        onPressed: () => _onPressed(context, ref, following),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          backgroundColor: filled ? AppColors.blue : AppColors.white,
          foregroundColor: filled ? AppColors.white : AppColors.blue,
          side: filled ? null : const BorderSide(color: AppColors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: context.typo.labelBold.copyWith(
            color: filled ? AppColors.white : AppColors.blue,
          ),
        ),
      ),
    );
  }
}
