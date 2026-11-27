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
import '../../../core/widgets/listy_header.dart';

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
      appBar: ListyHeader(
        title: l10n.notification_title,
        actions: [
          TextButton(
            key: const Key('notification.readAll'),
            // web `NotificationList.css.ts` readAllButton: LabelBold blue, 비활성 lightgray.
            style: TextButton.styleFrom(
              disabledForegroundColor: AppColors.lightgray,
            ),
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

    // web `NotificationList.css.ts`: 아래 24, 알림 사이 6, 지난 알림 앞 1px line (위아래 6).
    return ListView(
      key: const Key('notification.list'),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      children: [
        if (firstOld != 0)
          // label: BodyBold 흰 pill (padding 5 10), 오른쪽 정렬, margin 18 16.
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n.notification_recent,
                style: context.typo.bodyBold.copyWith(color: AppColors.blue),
              ),
            ),
          ),
        for (final (index, n) in items.indexed) ...[
          if (index > 0) const SizedBox(height: 6),
          if (index == firstOld)
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
              child: Divider(height: 1),
            ),
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
    // web date: LabelSmall lightgray, 메시지 뒤 4.
    final dateStyle = context.typo.labelSmall.copyWith(
      color: AppColors.lightgray,
    );
    final date = timeDiff(n.createdDate, l10n);
    if (n.type == NotificationKind.notice) {
      final notice = n.notice;
      return InkWell(
        key: Key('notification.${n.id}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // infoLabel: 흰 pill padding 4 8, blue.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      notice?.categoryViewName ?? '',
                      style: context.typo.label.copyWith(color: AppColors.blue),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      notice?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.labelBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                notice?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.typo.label.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 4),
              Text(date, style: dateStyle),
            ],
          ),
        ),
      );
    }
    // web message: 14/500, line 20, +0.2. 읽은 알림은 lightgray.
    final color = n.checked ? AppColors.lightgray : AppColors.black;
    final message = context.typo.label.copyWith(
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      letterSpacing: 0.2,
      color: color,
    );
    return InkWell(
      key: Key('notification.${n.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap == null
                  ? null
                  : () => context.push(AppRoutes.myList('${n.sendUser.id}')),
              // ProfileImage.css.ts: 45 원, 흰 바탕, 1px blue 테두리.
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.blue),
                ),
                child: UserProfileImage(
                  src: n.sendUser.profileImageUrl,
                  size: 43,
                  semanticLabel: l10n.notification_profileImageAlt,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: n.sendUser.nickname,
                      style: message.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: notificationMessage(l10n, n)),
                    TextSpan(text: '  $date', style: dateStyle),
                  ],
                ),
                style: message,
              ),
            ),
            if (!n.checked)
              Container(
                key: Key('notification.${n.id}.unread'),
                width: 6,
                height: 6,
                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
