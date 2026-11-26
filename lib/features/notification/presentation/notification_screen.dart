import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/notification_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/toast.dart';
import '../../../core/widgets/user_profile_image.dart';
import '../application/notification_providers.dart';

/// web `src/app/notification` (page + NotificationList). 로그인 사용자만 들어온다 (auth guard).
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifications = ref.watch(notificationsProvider);
    final hasNew = ref.watch(hasNewNotificationProvider);
    final items = notifications.value;

    final Widget body;
    if (items == null && notifications.hasError) {
      body = ListView(
        children: [
          ErrorView(
            error: notifications.error!,
            onRetry: () => ref.invalidate(notificationsProvider),
          ),
        ],
      );
    } else if (items == null) {
      body = Skeletonizer(
        child: ListView(
          children: [for (var i = 0; i < 6; i++) _skeletonTile(i)],
        ),
      );
    } else if (items.isEmpty) {
      body = ListView(
        children: [
          NoDataView(
            message: l10n.notification_allRead,
            description: l10n.notification_description,
          ),
        ],
      );
    } else {
      body = _NotificationList(items: items);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.notification_title, style: context.typo.bodyBold),
        actions: [
          TextButton(
            key: const Key('notification.readAll'),
            // web 과 같이 모두 읽었거나 확인 중이면 누를 수 없다.
            onPressed: hasNew.value ?? false
                ? () async {
                    try {
                      await ref.read(notificationActionsProvider).readAll();
                    } on Exception {
                      if (context.mounted) {
                        showToast(context, l10n.error_loadFailed);
                      }
                    }
                  }
                : null,
            child: Text(l10n.notification_readAll),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(notificationsProvider)
            ..invalidate(hasNewNotificationProvider);
          await ref.read(notificationsProvider.future);
        },
        child: body,
      ),
    );
  }

  Widget _skeletonTile(int i) => NotificationTile(
    notification: NotificationType(
      id: i,
      createdDate: '2024-01-01T00:00:00',
      checked: true,
      type: NotificationKind.follow,
      sendUser: const NotificationUser(
        id: 0,
        nickname: 'nickname',
        profileImageUrl: null,
      ),
      list: null,
      comment: null,
      reply: null,
      notice: null,
    ),
    onTap: null,
  );
}

/// web 은 7일이 지난 첫 알림 앞에 구분선을 둔다.
class _NotificationList extends ConsumerWidget {
  const _NotificationList({required this.items});

  final List<NotificationType> items;

  static const _recentDays = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final firstOld = items.indexWhere((n) {
      final date = DateTime.tryParse(n.createdDate);
      return date != null && now.difference(date).inDays >= _recentDays;
    });

    Future<void> open(NotificationType n) async {
      final router = GoRouter.of(context);
      final path = notificationTarget(n);
      // web 과 같이 읽음 요청을 보내고 결과를 기다리지 않고 이동한다.
      ref.read(notificationActionsProvider).read(n.id).ignore();
      if (path != null) await router.push(path);
    }

    return ListView(
      key: const Key('notification.list'),
      children: [
        if (firstOld != 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Text(
              l10n.notification_recent,
              style: context.typo.labelBold.copyWith(color: AppColors.gray),
            ),
          ),
        for (final (index, n) in items.indexed) ...[
          if (index == firstOld) const Divider(height: 24, thickness: 6),
          NotificationTile(notification: n, onTap: () => open(n)),
        ],
      ],
    );
  }
}

/// 알림을 눌렀을 때 갈 곳 (web `dataToPath`). 앱은 COLLABORATOR, REACTION 도 리스트로 보낸다.
String? notificationTarget(NotificationType n) {
  final listId = n.list?.id;
  return switch (n.type) {
    NotificationKind.follow => AppRoutes.myList('${n.sendUser.id}'),
    NotificationKind.notice => switch (n.notice?.id) {
      final id? => AppRoutes.noticeDetail('$id'),
      null => null,
    },
    NotificationKind.collect ||
    NotificationKind.comment ||
    NotificationKind.reply ||
    NotificationKind.mention ||
    NotificationKind.collaborator ||
    NotificationKind.reaction =>
      listId == null ? null : AppRoutes.listDetail('$listId'),
    NotificationKind.unknown => null,
  };
}

/// web `dataToMessage`. 닉네임 뒤에 붙는 문구다.
String notificationMessage(AppLocalizations l10n, NotificationType n) {
  final title = n.list?.title ?? '';
  return switch (n.type) {
    NotificationKind.follow => l10n.notification_follow,
    NotificationKind.collect => l10n.notification_collect(title),
    NotificationKind.comment => l10n.notification_comment(title),
    NotificationKind.reply => l10n.notification_reply,
    NotificationKind.mention => l10n.notification_mention(
      n.reply?.content ?? n.comment?.content ?? '',
    ),
    NotificationKind.collaborator => l10n.notification_collaborator(title),
    NotificationKind.reaction => l10n.notification_reaction(title),
    NotificationKind.notice || NotificationKind.unknown => '',
  };
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationType notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final n = notification;
    final date = Text(
      timeDiff(n.createdDate, l10n),
      style: context.typo.labelSmall.copyWith(color: AppColors.gray),
    );
    if (n.type == NotificationKind.notice) {
      final notice = n.notice;
      return InkWell(
        key: Key('notification.${n.id}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightblue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      notice?.categoryViewName ?? '',
                      style: context.typo.labelSmall.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      notice?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.labelBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                notice?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.typo.label.copyWith(color: AppColors.gray3),
              ),
              const SizedBox(height: 4),
              date,
            ],
          ),
        ),
      );
    }
    final color = n.checked ? AppColors.gray : AppColors.black;
    return InkWell(
      key: Key('notification.${n.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap == null
                  ? null
                  : () => context.push(AppRoutes.myList('${n.sendUser.id}')),
              child: UserProfileImage(
                src: n.sendUser.profileImageUrl,
                size: 40,
                semanticLabel: l10n.notification_profileImageAlt,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: n.sendUser.nickname,
                          style: context.typo.labelBold.copyWith(color: color),
                        ),
                        TextSpan(
                          text: notificationMessage(l10n, n),
                          style: context.typo.label.copyWith(color: color),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  date,
                ],
              ),
            ),
            if (!n.checked)
              Container(
                key: Key('notification.${n.id}.unread'),
                width: 6,
                height: 6,
                margin: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
