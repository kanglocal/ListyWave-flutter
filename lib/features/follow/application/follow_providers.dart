import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/follow_type.dart';
import '../../user/application/user_providers.dart';
import '../data/follow_api.dart';

/// web QUERY_KEYS.getFollowerList. web 과 같이 첫 응답만 쓴다.
/// 내 팔로워 삭제는 낙관적으로 목록에서 먼저 빼고, 실패하면 되돌린다.
class FollowerListNotifier extends AsyncNotifier<FollowerListType> {
  FollowerListNotifier(this.userId);

  final int userId;

  @override
  Future<FollowerListType> build() =>
      ref.watch(followApiProvider).getFollowerList(userId);

  /// web `UserList.tsx` DeleteFollowerButton (`DELETE /followers/{id}`).
  Future<void> removeFollower(int followerId) async {
    final previous = state.value;
    if (previous == null) return;
    state = AsyncData(
      previous.copyWith(
        followers: previous.followers.where((u) => u.id != followerId).toList(),
        totalCount: previous.totalCount - 1,
      ),
    );
    try {
      await ref.read(followApiProvider).deleteFollower(followerId);
    } catch (_) {
      state = AsyncData(previous);
      rethrow;
    }
    ref.invalidate(userProvider(userId));
  }
}

final followerListProvider = AsyncNotifierProvider.autoDispose
    .family<FollowerListNotifier, FollowerListType, int>(
      FollowerListNotifier.new,
    );

/// web QUERY_KEYS.getFollowingList.
final followingListProvider = FutureProvider.autoDispose
    .family<FollowingListType, int>(
      (ref, userId) => ref.watch(followApiProvider).getFollowingList(userId),
    );

/// 화면마다 따로 받은 팔로우 여부(프로필 `isFollowed`, 리스트 상세 `isFollowing`, 검색
/// `isFollowing` …) 위에 이 앱에서 바꾼 값을 덮어쓴다. 키는 상대 userId 다.
///
/// 낙관적 업데이트 (PLAN §5.2): 값을 먼저 바꾸고 API 가 실패하면 이전 값으로 되돌린다.
/// 로그인 사용자가 바뀌면 비운다.
class FollowController extends Notifier<Map<int, bool>> {
  final Set<int> _pending = {};

  @override
  Map<int, bool> build() {
    ref.watch(currentUserIdProvider);
    _pending.clear();
    return const {};
  }

  /// [current] 의 반대로 바꾼다. 같은 사용자에 대한 요청이 진행 중이면 무시한다.
  Future<void> toggle(int userId, {required bool current}) async {
    if (!_pending.add(userId)) return;
    final hadOverride = state.containsKey(userId);
    final previousOverride = state[userId];
    final next = !current;
    state = {...state, userId: next};
    try {
      final api = ref.read(followApiProvider);
      if (next) {
        await api.follow(userId);
      } else {
        await api.unfollow(userId);
      }
    } catch (_) {
      // 다른 사용자에 대한 변경은 그대로 두고 이 사용자만 되돌린다.
      final rolledBack = {...state}..remove(userId);
      if (hadOverride) rolledBack[userId] = previousOverride!;
      state = rolledBack;
      rethrow;
    } finally {
      _pending.remove(userId);
    }
    final me = ref.read(currentUserIdProvider);
    ref.invalidate(userProvider(userId));
    if (me != null) {
      ref
        ..invalidate(userProvider(me))
        ..invalidate(followingListProvider(me));
    }
  }
}

final followControllerProvider =
    NotifierProvider<FollowController, Map<int, bool>>(FollowController.new);

/// 서버 값 [serverValue] 에 이 앱에서 바꾼 값을 덮어쓴 팔로우 여부.
bool watchIsFollowing(WidgetRef ref, int userId, {required bool serverValue}) =>
    ref.watch(followControllerProvider.select((m) => m[userId])) ?? serverValue;
