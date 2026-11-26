import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';

/// web `search/_components/Top3Card.tsx`. 대표 이미지가 있으면 둥근 이미지 카드, 없으면 사각 카드.
class Top3Card extends StatelessWidget {
  const Top3Card({super.key, required this.list});

  final SearchListType list;

  @override
  Widget build(BuildContext context) {
    final hasImage = list.representImageUrl?.isNotEmpty ?? false;
    final textColor = hasImage ? AppColors.white : AppColors.black;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.listDetail('${list.id}')),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(hasImage ? 80 : 16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage) ...[
              AppNetworkImage(url: list.representImageUrl),
              const ColoredBox(color: Color(0x66000000)),
            ] else
              ColoredBox(
                color:
                    ListBackgroundColors.read[list.backgroundColor] ??
                    AppColors.bggray,
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: hasImage ? 22 : 14,
                vertical: 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: hasImage
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    list.categoryKorName,
                    style: context.typo.labelSmall.copyWith(
                      color: hasImage ? AppColors.skyblue : AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    list.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: hasImage ? TextAlign.center : TextAlign.start,
                    style: context.typo.bodyBold.copyWith(color: textColor),
                  ),
                  Text(
                    list.ownerNickname,
                    style: context.typo.labelSmall.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 6),
                  for (final (index, item) in list.items.indexed)
                    Text(
                      '${index + 1}. ${item.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.labelSmall.copyWith(color: textColor),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    formatDate(list.updatedDate),
                    style: context.typo.labelSmall.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
