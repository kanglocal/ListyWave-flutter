import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/require_login.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/requested_topic_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/infinite_scroll.dart';
import '../../../core/widgets/no_data.dart';
import '../application/topics_providers.dart';
import 'widgets/topic_request_sheet.dart';
import '../../../core/widgets/listy_header.dart';

/// web `/topics`: 요청 주제 목록 (infinite) + 주제 요청 bottom sheet.
/// 주제를 누르면 그 제목과 카테고리로 리스트 만들기를 연다.
class TopicsScreen extends ConsumerWidget {
  const TopicsScreen({super.key});

  Future<void> _request(BuildContext context, WidgetRef ref) async {
    if (requireLogin(context) == null) return;
    final sent = await showTopicRequestSheet(context);
    if (sent == true) ref.invalidate(topicsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(topicsProvider);
    final page = topics.value;

    final Widget body;
    if (page == null && topics.hasError) {
      body = ErrorView(
        error: topics.error!,
        onRetry: () => ref.invalidate(topicsProvider),
      );
    } else if (page == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = InfiniteScroll(
        canLoadMore: page.hasNext && !page.isLoadingMore,
        onLoadMore: () => ref.read(topicsProvider.notifier).loadMore(),
        child: RefreshIndicator(
          onRefresh: () => ref.read(topicsProvider.notifier).refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            children: [
              Text(l10n.topics_title, style: context.typo.header),
              const SizedBox(height: 8),
              Text(
                l10n.topics_subtitle,
                style: context.typo.label.copyWith(color: AppColors.gray),
              ),
              const SizedBox(height: 20),
              if (page.items.isEmpty) NoDataView(message: l10n.topics_empty),
              for (final topic in page.items) _TopicBox(topic: topic),
              if (page.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const ListyHeader(),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('topics.request'),
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        onPressed: () => _request(context, ref),
        label: Text(l10n.topics_request),
      ),
    );
  }
}

/// web `TopicBox.tsx`.
class _TopicBox extends StatelessWidget {
  const _TopicBox({required this.topic});

  final RequestedTopicType topic;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Material(
        color: AppColors.bggray,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          key: Key('topics.topic.${topic.id}'),
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(
            Uri(
              path: AppRoutes.listCreate,
              queryParameters: {
                'title': topic.title,
                'category': topic.categoryKorName,
              },
            ).toString(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.categoryKorName,
                  style: context.typo.labelSmall.copyWith(
                    color: AppColors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(topic.title, style: context.typo.bodyBold),
                if (topic.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    topic.description,
                    style: context.typo.label.copyWith(color: AppColors.gray3),
                  ),
                ],
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    topic.isAnonymous
                        ? l10n.topics_anonymous
                        : topic.ownerNickname,
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
