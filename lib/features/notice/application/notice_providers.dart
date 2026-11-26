import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/notice_type.dart';
import '../../../core/pagination/cache_for.dart';
import '../data/notice_api.dart';

/// web QUERY_KEYS.getAllNotices (staleTime 30분, `NoticeList.tsx`).
final noticesProvider = FutureProvider.autoDispose<List<NoticeListItemType>>((
  ref,
) {
  ref.cacheFor(const Duration(minutes: 30));
  return ref.watch(noticeApiProvider).getNotices();
});

/// web QUERY_KEYS.getNoticeDetail.
final noticeDetailProvider = FutureProvider.autoDispose
    .family<NoticeDetailType, int>(
      (ref, noticeId) => ref.watch(noticeApiProvider).getNoticeDetail(noticeId),
    );
