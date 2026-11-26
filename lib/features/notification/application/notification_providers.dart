import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/notification_type.dart';
import '../data/notification_api.dart';

/// web QUERY_KEYS.notifications.
final notificationsProvider =
    FutureProvider.autoDispose<List<NotificationType>>((ref) {
      ref.watch(currentUserIdProvider);
      return ref.watch(notificationApiProvider).getNotifications();
    });

/// 읽지 않은 알림이 있는가 (web QUERY_KEYS.getNotificationAllChecked 의 반대).
/// 로그인하지 않았으면 부르지 않고 false 다 (PLAN §11 Q7: 홈 진입 시 조회).
final hasNewNotificationProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  if (ref.watch(currentUserIdProvider) == null) return false;
  final result = await ref.watch(notificationApiProvider).checkNew();
  return !result.isAllChecked;
});

/// 읽음 처리. 성공하면 목록과 뱃지를 다시 읽는다.
class NotificationActions {
  const NotificationActions(this._ref);

  final Ref _ref;

  Future<void> read(int alarmId) async {
    await _ref.read(notificationApiProvider).read(alarmId);
    _refresh();
  }

  Future<void> readAll() async {
    await _ref.read(notificationApiProvider).readAll();
    _refresh();
  }

  void _refresh() => _ref
    ..invalidate(notificationsProvider)
    ..invalidate(hasNewNotificationProvider);
}

final notificationActionsProvider = Provider<NotificationActions>(
  NotificationActions.new,
);
