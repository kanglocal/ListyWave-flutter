import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
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
import '../../../core/widgets/link_preview.dart';
import '../application/notice_providers.dart';

/// web `/notice/[noticeId]` (`NoticeDetail.tsx`, `components/NoticeDetail/*`).
class NoticeDetailScreen extends ConsumerWidget {
  const NoticeDetailScreen({super.key, required this.noticeId});

  final String noticeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(noticeId);
    final detail = id == null ? null : ref.watch(noticeDetailProvider(id));
    final Widget body = switch (detail) {
      null => ErrorView(error: ArgumentError.value(noticeId)),
      AsyncData(:final value) => _NoticeBody(notice: value),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(noticeDetailProvider(id!)),
      ),
      _ => const Skeletonizer(
        child: _NoticeBody(
          notice: NoticeDetailType(
            id: 0,
            category: 'category',
            title: 'notice title',
            description: 'notice description',
            contents: [],
            createdDate: '2024-01-01T00:00:00',
            prevNotice: null,
            nextNotice: null,
          ),
        ),
      ),
    };
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.notice_title, style: context.typo.bodyBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: body,
      ),
    );
  }
}

class _NoticeBody extends StatelessWidget {
  const _NoticeBody({required this.notice});

  final NoticeDetailType notice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notice.category,
          style: context.typo.labelBold.copyWith(color: AppColors.blue),
        ),
        const SizedBox(height: 6),
        Text(notice.title, style: context.typo.header),
        const SizedBox(height: 6),
        Text(
          notice.description,
          style: context.typo.body.copyWith(color: AppColors.gray3),
        ),
        const SizedBox(height: 6),
        Text(
          formatDate(notice.createdDate),
          style: context.typo.labelSmall.copyWith(color: AppColors.gray),
        ),
        const Divider(height: 32),
        for (final content in notice.contents)
          NoticeContentBlock(content: content),
        const SizedBox(height: 32),
        if (notice.prevNotice case final prev?)
          _BesideNotice(label: l10n.notice_prev, notice: prev),
        if (notice.nextNotice case final next?)
          _BesideNotice(label: l10n.notice_next, notice: next),
        const SizedBox(height: 16),
        Center(
          child: OutlinedButton(
            onPressed: () => context.go(AppRoutes.notice),
            child: Text(l10n.notice_backToList),
          ),
        ),
      ],
    );
  }
}

/// web `NoticeDetailContents.tsx` 의 블록 종류별 렌더링. body 는 markdown 이다.
class NoticeContentBlock extends StatelessWidget {
  const NoticeContentBlock({super.key, required this.content});

  final NoticeContentType content;

  @override
  Widget build(BuildContext context) {
    final description = content.description ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: switch (content.type) {
        NoticeContentsType.subtitle => Text(
          description,
          style: context.typo.subtitle,
        ),
        NoticeContentsType.body => MarkdownBody(
          data: description,
          onTapLink: (_, href, _) {
            if (href != null) openExternalUrl(href);
          },
        ),
        NoticeContentsType.image => ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AppNetworkImage(
            url: content.imageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        NoticeContentsType.button => SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: content.buttonLink == null
                ? null
                : () => openExternalUrl(content.buttonLink!),
            child: Text(content.buttonName ?? ''),
          ),
        ),
        NoticeContentsType.line => const Divider(),
        NoticeContentsType.note => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.bggray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            description,
            style: context.typo.label.copyWith(color: AppColors.gray3),
          ),
        ),
        NoticeContentsType.unknown => const SizedBox.shrink(),
      },
    );
  }
}

class _BesideNotice extends StatelessWidget {
  const _BesideNotice({required this.label, required this.notice});

  final String label;
  final BesideNoticeType notice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.pushReplacement(AppRoutes.noticeDetail('${notice.id}')),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.typo.labelSmall.copyWith(color: AppColors.blue),
            ),
            Text(notice.title, style: context.typo.bodyBold),
            Text(
              notice.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }
}
