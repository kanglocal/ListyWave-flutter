import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/follow_type.dart';
import '../data/follow_api.dart';

/// web QUERY_KEYS.getFollowerList. web 과 같이 첫 응답만 쓴다.
final followerListProvider = FutureProvider.autoDispose
    .family<FollowerListType, int>(
      (ref, userId) => ref.watch(followApiProvider).getFollowerList(userId),
    );

/// web QUERY_KEYS.getFollowingList.
final followingListProvider = FutureProvider.autoDispose
    .family<FollowingListType, int>(
      (ref, userId) => ref.watch(followApiProvider).getFollowingList(userId),
    );
