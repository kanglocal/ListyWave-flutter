import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

/// [SimpleRankList] 한 줄.
typedef RankedTitle = ({int rank, String title});

/// web `src/components/SimpleList/SimpleList.tsx`. 1위에는 하트를 붙이고 굵게 쓴다.
class SimpleRankList extends StatelessWidget {
  const SimpleRankList({super.key, required this.items});

  final List<RankedTitle> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                // 글자가 커지면 순위 칸도 넓어진다.
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 36),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.rank == 1)
                        SvgPicture.asset(
                          'assets/icons/ver3/blue_heart.svg',
                          width: 14,
                          height: 14,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        '${item.rank}',
                        style: item.rank == 1
                            ? context.typo.bodyBold.copyWith(
                                color: AppColors.blue,
                              )
                            : context.typo.body.copyWith(color: AppColors.gray),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: item.rank == 1
                        ? context.typo.bodyBold.copyWith(color: AppColors.black)
                        : context.typo.body.copyWith(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
