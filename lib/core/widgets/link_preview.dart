import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/gen/app_localizations.dart';
import '../link_preview/link_preview_fetcher.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import 'app_network_image.dart';

Future<void> openExternalUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

/// web `src/components/LinkPreview/LinkPreview.tsx`. 누르면 외부 브라우저로 연다.
class LinkPreview extends ConsumerWidget {
  const LinkPreview({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final preview = ref.watch(linkPreviewProvider(url));
    final Widget content = switch (preview) {
      AsyncData(:final value) when value.hasContent => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value.image?.isNotEmpty ?? false) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(url: value.image, width: 72, height: 72),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (value.title?.isNotEmpty ?? false)
                      ? value.title!
                      : l10n.common_noTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.labelBold.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (value.description?.isNotEmpty ?? false)
                      ? value.description!
                      : l10n.common_noDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  value.url ?? url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.labelSmall.copyWith(
                    color: AppColors.bluegray8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      AsyncData() => Center(
        child: Text(
          l10n.linkPreview_goToLink,
          style: context.typo.labelBold.copyWith(color: AppColors.blue),
        ),
      ),
      AsyncError() => Text(
        l10n.common_failToBringPreview,
        style: context.typo.label.copyWith(color: AppColors.gray),
      ),
      _ => Text(
        l10n.common_loading,
        style: context.typo.label.copyWith(color: AppColors.gray),
      ),
    };
    return Semantics(
      link: true,
      child: InkWell(
        onTap: () => openExternalUrl(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.bggray),
          ),
          child: content,
        ),
      ),
    );
  }
}
