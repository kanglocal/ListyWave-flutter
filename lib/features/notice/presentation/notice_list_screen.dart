import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/notice_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/no_data.dart';
import '../application/notice_providers.dart';

/// web `/notice` (`NoticeList.tsx`).
class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notices = ref.watch(noticesProvider);
    final Widget body = switch (notices) {
      AsyncData(:final value) when value.isEmpty => ListView(
        children: [NoDataView(message: l10n.notice_empty)],
      ),
      AsyncData(:final value) => ListView.separated(
        key: const Key('notice.list'),
        itemCount: value.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) => NoticeListTile(item: value[index]),
      ),
      AsyncError(:final error) => ListView(
        children: [
          ErrorView(
            error: error,
            onRetry: () => ref.invalidate(noticesProvider),
          ),
        ],
      ),
      _ => Skeletonizer(
        child: ListView(
          children: [
            for (var i = 0; i < 5; i++)
              NoticeListTile(
                item: NoticeListItemType(
                  id: i,
                  createdDate: '2024-01-01T00:00:00',
                  title: 'notice title',
                  itemImageUrl: null,
                  category: 'category',
                  description: 'notice description',
                ),
              ),
          ],
        ),
      ),
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.notice_title, style: context.typo.bodyBold),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(noticesProvider);
          await ref.read(noticesProvider.future);
        },
        child: body,
      ),
    );
  }
}

class NoticeListTile extends StatelessWidget {
  const NoticeListTile({super.key, required this.item});

  final NoticeListItemType item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.noticeDetail('${item.id}')),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: context.typo.bodyBold),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typo.label.copyWith(color: AppColors.gray3),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        formatDate(item.createdDate),
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.gray,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.category,
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (item.itemImageUrl?.isNotEmpty ?? false) ...[
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AppNetworkImage(
                  url: item.itemImageUrl,
                  width: 72,
                  height: 72,
                  semanticLabel: item.title,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
