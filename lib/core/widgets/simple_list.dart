import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

/// [SimpleRankList] 한 줄.
typedef RankedTitle = ({int rank, String title});

/// web `src/components/SimpleList` (3.0). 1위는 순위 숫자 뒤에 파란 하트(48x41)를 깔고 제목을 blue 600 으로 쓴다.
/// 순위 칸 35x35, 줄 높이 50, 순위와 제목 사이 16.
class SimpleRankList extends StatelessWidget {
  const SimpleRankList({super.key, required this.items});

  final List<RankedTitle> items;

  @override
  Widget build(BuildContext context) {
    final rankStyle = context.typo.subtitle.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: -0.6,
      color: AppColors.gray4,
    );
    final titleStyle = context.typo.bodyRegular.copyWith(
      color: AppColors.black3,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in items)
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 50),
            child: Row(
              children: [
                // 글자가 커지면 순위 칸도 넓어진다.
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      if (item.rank == 1)
                        SvgPicture.asset(
                          'assets/icons/ver3/blue_heart.svg',
                          width: 48,
                          height: 41,
                        ),
                      Text(
                        '${item.rank}',
                        style: item.rank == 1
                            ? rankStyle.copyWith(color: AppColors.blue)
                            : rankStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: item.rank == 1
                        ? titleStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue,
                          )
                        : titleStyle,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
