import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/history_type.dart';
import '../data/history_api.dart';

/// web QUERY_KEYS.getHistories. backend 는 정렬 없이 주므로 만든 시각 오름차순(오래된 것부터)
/// 으로 맞춘다. web 은 마지막 항목을 최신 버전으로 본다.
///
/// 공개 토글은 낙관적으로 바꾸고 실패하면 되돌린다 (web `HistoryVersions.tsx`).
class HistoriesNotifier extends AsyncNotifier<List<HistoryType>> {
  HistoriesNotifier(this.listId);

  final int listId;

  @override
  Future<List<HistoryType>> build() async {
    final histories = await ref.watch(historyApiProvider).getHistories(listId);
    return [...histories]
      ..sort((a, b) => a.createdDate.compareTo(b.createdDate));
  }

  Future<void> togglePublic(int historyId) async {
    final previous = state.value;
    if (previous == null) return;
    state = AsyncData([
      for (final h in previous)
        h.id == historyId ? h.copyWith(isPublic: !h.isPublic) : h,
    ]);
    try {
      await ref.read(historyApiProvider).togglePublic(historyId);
    } catch (_) {
      state = AsyncData(previous);
      rethrow;
    }
  }

  /// 지우고 목록을 다시 읽는다 (web 은 예전에 다른 키를 무효화해서 지운 버전이 남았다).
  Future<void> delete(int historyId) async {
    await ref.read(historyApiProvider).delete(historyId);
    ref.invalidateSelf();
  }
}

final historiesProvider = AsyncNotifierProvider.autoDispose
    .family<HistoriesNotifier, List<HistoryType>, int>(HistoriesNotifier.new);
