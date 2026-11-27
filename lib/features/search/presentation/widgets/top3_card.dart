import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';

/// web `search/_components/Top3Card.tsx` (`Top3Card.css.ts`). 높이 191. 대표 이미지가 있으면
/// 50% 검정을 덮은 타원, 없으면 radius 20 흰 카드다. 내용은 가운데 정렬 (padding 32).
class Top3Card extends StatelessWidget {
  const Top3Card({super.key, required this.list});

  final SearchListType list;

  static const height = 191.0;

  @override
  Widget build(BuildContext context) {
    final hasImage = list.representImageUrl?.isNotEmpty ?? false;
    final textColor = hasImage ? AppColors.white : AppColors.black;
    final content = Stack(
      fit: StackFit.expand,
      children: [
        if (hasImage) ...[
          AppNetworkImage(url: list.representImageUrl),
          const ColoredBox(color: Color(0x80000000)),
        ] else
          const ColoredBox(color: AppColors.white),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          // 높이가 고정이라 글자가 커지면 (접근성 글자 크기) 넘치는 대신 내용 전체를 줄인다.
          child: LayoutBuilder(
            builder: (context, constraints) => FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // category: LabelSmall, blue 바탕 흰 글자, padding 2 6, radius 20.
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        list.categoryKorName,
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      list.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.typo.labelBold.copyWith(color: textColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      list.ownerNickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.labelSmall.copyWith(
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    for (final (index, item) in list.items.indexed) ...[
                      if (index > 0) const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.2,
                          vertical: 4.5,
                        ),
                        decoration: BoxDecoration(
                          color: hasImage
                              ? const Color(0x4DF5FAFF)
                              : const Color(0xFFF5FAFF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          '${index + 1}. ${item.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typo.label.copyWith(
                            fontSize: 10,
                            letterSpacing: 0,
                            color: hasImage ? AppColors.white : AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      formatDate(list.updatedDate),
                      style: context.typo.label.copyWith(
                        fontSize: 9,
                        letterSpacing: 0,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: () => context.push(AppRoutes.listDetail('${list.id}')),
      child: SizedBox(
        height: height,
        child: hasImage
            ? ClipOval(child: content)
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: content,
              ),
      ),
    );
  }
}
