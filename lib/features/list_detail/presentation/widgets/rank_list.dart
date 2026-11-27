import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/video_embed.dart';

/// web `ListDetailInner/Header.tsx` + `RankList.tsx`: 업데이트 정보와 간단히/자세히 보기.
class RankListSection extends StatefulWidget {
  const RankListSection({super.key, required this.list});

  final ListDetailType list;

  @override
  State<RankListSection> createState() => _RankListSectionState();
}

enum _ListViewType { simple, detail }

class _RankListSectionState extends State<RankListSection> {
  _ListViewType _type = _ListViewType.simple;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final list = widget.list;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 한 줄에 안 들어가면 (큰 글씨) 보기 방식 선택이 다음 줄로 내려간다.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: 8,
              children: [
                Text(
                  formatDateTime(list.lastUpdatedDate),
                  style: context.typo.labelSmall.copyWith(
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  list.updateCount == 0
                      ? l10n.listDetail_firstUpload
                      : l10n.home_updateCount(list.updateCount),
                  style: context.typo.labelSmall.copyWith(
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            DropdownButton<_ListViewType>(
              key: const Key('listDetail.viewType'),
              value: _type,
              underline: const SizedBox.shrink(),
              style: context.typo.label.copyWith(color: AppColors.black),
              items: [
                DropdownMenuItem(
                  value: _ListViewType.simple,
                  child: Text(l10n.listDetail_simple),
                ),
                DropdownMenuItem(
                  value: _ListViewType.detail,
                  child: Text(l10n.listDetail_detail),
                ),
              ],
              onChanged: (type) => setState(() => _type = type ?? _type),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (list.items.isEmpty)
          Text(l10n.listDetail_noData)
        else
          for (final (index, item) in list.items.indexed)
            _type == _ListViewType.simple
                ? _SimpleItem(item: item, isFirst: index == 0)
                : _DetailItem(item: item, index: index),
      ],
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank, required this.highlight});

  final int rank;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: highlight ? AppColors.blue : AppColors.whiteblue,
      ),
      child: Text(
        '$rank',
        style: context.typo.labelBold.copyWith(
          color: highlight ? AppColors.white : AppColors.blue,
        ),
      ),
    );
  }
}

class _SimpleItem extends StatelessWidget {
  const _SimpleItem({required this.item, required this.isFirst});

  final ItemType item;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _RankBadge(rank: item.rank, highlight: isFirst),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: isFirst ? context.typo.bodyBold : context.typo.body,
            ),
          ),
          if (item.imageUrl?.isNotEmpty ?? false)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(
                url: item.imageUrl,
                width: 41,
                height: 41,
                semanticLabel: item.title,
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.item, required this.index});

  final ItemType item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bggray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (index == 0) ...[
                SvgPicture.asset(
                  'assets/icons/crown_new.svg',
                  width: 20,
                  height: 20,
                  semanticsLabel: l10n.listDetail_crown,
                ),
                const SizedBox(width: 6),
              ],
              _RankBadge(rank: item.rank, highlight: index < 3),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: index == 0
                      ? context.typo.subtitle
                      : context.typo.bodyBold,
                ),
              ),
            ],
          ),
          if (item.comment?.isNotEmpty ?? false) ...[
            const SizedBox(height: 10),
            Text(
              item.comment!,
              style: context.typo.body.copyWith(color: AppColors.gray3),
            ),
          ],
          if (item.imageUrl?.isNotEmpty ?? false) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppNetworkImage(
                url: item.imageUrl,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                semanticLabel: item.title,
              ),
            ),
          ],
          if (item.link?.isNotEmpty ?? false) ItemLinkEmbed(url: item.link!),
        ],
      ),
    );
  }
}
