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
    // web `ListDetailInner/Header.css.ts` infoDetailWrapper: 13/300 `black2`, 사이 13.
    final info = context.typo.label.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: AppColors.black2,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 한 줄에 안 들어가면 (큰 글씨) 보기 방식 선택이 다음 줄로 내려간다.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: 13,
              children: [
                Text(formatDateTime(list.lastUpdatedDate), style: info),
                Text(
                  list.updateCount == 0
                      ? l10n.listDetail_firstUpload
                      : l10n.home_updateCount(list.updateCount),
                  style: info,
                ),
              ],
            ),
            // web SelectComponent: 테두리 없음, 13 black.
            DropdownButton<_ListViewType>(
              key: const Key('listDetail.viewType'),
              value: _type,
              underline: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(8),
              dropdownColor: AppColors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.black,
                size: 20,
              ),
              style: context.typo.label.copyWith(
                fontSize: 13,
                letterSpacing: 0,
                color: AppColors.black,
              ),
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
        const SizedBox(height: 2),
        // web `ListDetailInner/index.css.ts` listAndFooter: 위 1px #D9D9D9.
        const Divider(height: 1, color: Color(0xFFD9D9D9)),
        // RankList.css.ts background: padding 24 0.
        const SizedBox(height: 24),
        if (list.items.isEmpty)
          Text(l10n.listDetail_noData)
        else
          for (final (index, item) in list.items.indexed)
            _type == _ListViewType.simple
                ? _SimpleItem(item: item, isFirst: index == 0)
                : _DetailItem(
                    item: item,
                    index: index,
                    isLast: index == list.items.length - 1,
                  ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// web `RankList.css.ts` 순위 칸 (40x40). 1위는 `blue_heart.svg` 위에 blue, 나머지는 18/500 `gray4`.
class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank, required this.isFirst});

  final int rank;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isFirst)
            SvgPicture.asset(
              'assets/icons/ver3/blue_heart.svg',
              width: 40,
              height: 40,
            ),
          Text(
            '$rank',
            style: context.typo.subtitle.copyWith(
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: 0,
              color: isFirst ? AppColors.blue : AppColors.gray4,
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle _titleStyle(BuildContext context, {required bool isFirst}) {
  final base = context.typo.bodyRegular.copyWith(
    letterSpacing: 0,
    color: AppColors.black3,
  );
  return isFirst
      ? base.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.48,
          color: AppColors.blue,
        )
      : base;
}

/// web simpleItemWrapper: 높이 52, 순위와 제목 사이 20, 오른쪽에 41 썸네일 (radius 10).
class _SimpleItem extends StatelessWidget {
  const _SimpleItem({required this.item, required this.isFirst});

  final ItemType item;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Row(
        children: [
          _RankBadge(rank: item.rank, isFirst: isFirst),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              item.title,
              style: _titleStyle(context, isFirst: isFirst),
            ),
          ),
          if (item.imageUrl?.isNotEmpty ?? false) ...[
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: AppColors.bggray,
                child: AppNetworkImage(
                  url: item.imageUrl,
                  width: 41,
                  height: 41,
                  semanticLabel: item.title,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// web detailItemWrapper: 아래 40 (마지막 0), 사이 4. 코멘트는 padding 10, 14 black.
class _DetailItem extends StatelessWidget {
  const _DetailItem({
    required this.item,
    required this.index,
    required this.isLast,
  });

  final ItemType item;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, isLast ? 0 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Semantics(
                label: index == 0 ? l10n.listDetail_crown : null,
                child: _RankBadge(rank: item.rank, isFirst: index == 0),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  item.title,
                  style: _titleStyle(context, isFirst: index == 0),
                ),
              ),
            ],
          ),
          if (item.comment?.isNotEmpty ?? false) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.comment!,
                style: context.typo.label.copyWith(
                  letterSpacing: 0,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
          if (item.imageUrl?.isNotEmpty ?? false) ...[
            const SizedBox(height: 4),
            AppNetworkImage(
              url: item.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              semanticLabel: item.title,
            ),
          ],
          if (item.link?.isNotEmpty ?? false) ...[
            const SizedBox(height: 4),
            ItemLinkEmbed(url: item.link!),
          ],
        ],
      ),
    );
  }
}
