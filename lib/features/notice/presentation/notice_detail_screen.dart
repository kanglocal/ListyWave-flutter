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
import '../../../core/widgets/listy_header.dart';

/// web `/notice/[noticeId]` (`NoticeDetail.tsx`, `components/NoticeDetail/*`).
class NoticeDetailScreen extends ConsumerWidget {
  const NoticeDetailScreen({super.key, required this.noticeId});

  final String noticeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    // web `notice/[noticeId]/NoticeDetail.tsx`: 제목 없이 blue 헤더에 lightgray 뒤로가기.
    return Scaffold(
      appBar: const ListyHeader(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.lightgray,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // web `NoticeDetailInfo.css.ts` info: blue, padding 25 16 40.
        Container(
          color: AppColors.blue,
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  notice.category,
                  style: context.typo.labelBold.copyWith(
                    color: AppColors.bluegray8,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                notice.title,
                style: context.typo.header.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 11),
              Text(
                notice.description,
                style: context.typo.label.copyWith(
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatDate(notice.createdDate),
                style: context.typo.label.copyWith(
                  fontSize: 10,
                  letterSpacing: 0,
                  color: AppColors.bggray,
                ),
              ),
            ],
          ),
        ),
        // contents: padding 20 16 0, 사이 15.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, content) in notice.contents.indexed) ...[
                if (i > 0) const SizedBox(height: 15),
                NoticeContentBlock(content: content),
              ],
            ],
          ),
        ),
        // signPostWrapper: padding 12 16 32, 사이 8.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (notice.prevNotice case final prev?)
                _BesideNotice(label: l10n.notice_prev, notice: prev),
              if (notice.nextNotice case final next?)
                _BesideNotice(label: l10n.notice_next, notice: next),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.notice),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.deepblue10,
                    textStyle: context.typo.label.copyWith(letterSpacing: 0),
                  ),
                  child: Text(l10n.notice_backToList),
                ),
              ),
            ],
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
    // web `NoticeDetailContents.css.ts`.
    return switch (content.type) {
      NoticeContentsType.subtitle => Text(
        description,
        style: context.typo.subtitle.copyWith(color: AppColors.black),
      ),
      NoticeContentsType.body => MarkdownBody(
        data: description,
        onTapLink: (_, href, _) {
          if (href != null) openExternalUrl(href);
        },
      ),
      // imgaeBox: 높이 400, cover, radius 5.
      NoticeContentsType.image => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: AppNetworkImage(
          url: content.imageUrl,
          width: double.infinity,
          height: 400,
        ),
      ),
      // button: 흰 바탕, 1px blue, radius 18, padding 16 14, BodyRegular 700 blue.
      NoticeContentsType.button => OutlinedButton(
        onPressed: content.buttonLink == null
            ? null
            : () => openExternalUrl(content.buttonLink!),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          side: const BorderSide(color: AppColors.blue),
          textStyle: context.typo.bodyRegular.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(content.buttonName ?? ''),
      ),
      // line: 2px lightblue, margin 10 0.
      NoticeContentsType.line => Container(
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.lightblue,
      ),
      // notice: Label bluegray8, 최소 120.
      NoticeContentsType.note => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 120),
        child: Text(
          description,
          style: context.typo.label.copyWith(color: AppColors.bluegray8),
        ),
      ),
      NoticeContentsType.unknown => const SizedBox.shrink(),
    };
  }
}

/// web 이전글/다음글 카드: 흰색 padding 18 14, radius 16. 표시는 12 deepblue10,
/// 제목 16/600 (위 4), 설명 12 (위 6).
class _BesideNotice extends StatelessWidget {
  const _BesideNotice({required this.label, required this.notice});

  final String label;
  final BesideNoticeType notice;

  @override
  Widget build(BuildContext context) {
    final ink = context.typo.label.copyWith(color: AppColors.black);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              context.pushReplacement(AppRoutes.noticeDetail('${notice.id}')),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: ink.copyWith(
                    fontSize: 12,
                    letterSpacing: 0,
                    color: AppColors.deepblue10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notice.title,
                  style: context.typo.bodyBold.copyWith(
                    letterSpacing: -0.48,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notice.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ink.copyWith(fontSize: 12, letterSpacing: -0.36),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
