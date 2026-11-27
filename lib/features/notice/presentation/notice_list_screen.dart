import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../core/widgets/listy_header.dart';

/// web `/notice` (`NoticeList.tsx`).
class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notices = ref.watch(noticesProvider);
    final Widget body = switch (notices) {
      AsyncData(:final value) when value.isEmpty => ListView(
        children: [
          NoDataView(
            image: SvgPicture.asset(
              'assets/images/no_data_image.svg',
              width: 120,
              height: 120,
            ),
            message: l10n.notice_empty,
            description: l10n.notice_emptyDescription,
          ),
        ],
      ),
      // web NoticeList.css.ts: margin-top 14, padding 0 16, 사이 12.
      AsyncData(:final value) => ListView.separated(
        key: const Key('notice.list'),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        itemCount: value.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
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
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
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
      appBar: ListyHeader(title: l10n.notice_title),
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

/// web NoticeListItem: 흰 카드 padding 18 14, radius 16. 제목 16/600, 설명 14, 날짜 13 #495866,
/// 카테고리는 #E3EEFF pill 에 blue 13/500. 이미지는 오른쪽 90 폭.
class NoticeListTile extends StatelessWidget {
  const NoticeListTile({super.key, required this.item});

  final NoticeListItemType item;

  @override
  Widget build(BuildContext context) {
    final ink = context.typo.label.copyWith(color: AppColors.black);
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(AppRoutes.noticeDetail('${item.id}')),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: context.typo.bodyBold.copyWith(
                        letterSpacing: -0.48,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: ink.copyWith(letterSpacing: -0.42),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          formatDate(item.createdDate),
                          style: ink.copyWith(
                            fontSize: 13,
                            letterSpacing: -0.39,
                            color: const Color(0xFF495866),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightblue2,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            item.category,
                            style: ink.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.39,
                              color: AppColors.blue,
                            ),
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
                  borderRadius: BorderRadius.circular(16),
                  child: AppNetworkImage(
                    url: item.itemImageUrl,
                    width: 90,
                    height: 90,
                    semanticLabel: item.title,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
