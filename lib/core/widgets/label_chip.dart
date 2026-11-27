import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

enum LabelChipType { blue, skyblue, white, tag }

/// web `src/components/Label/Label.css.ts`: `Label` 14, padding 2 12, radius 16, 높이 24.
/// tag 는 배경·테두리 없이 `black3` 의 `#` 를 앞에 붙인다.
class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.text,
    this.type = LabelChipType.blue,
    this.onTap,
  });

  final String text;
  final LabelChipType type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.typo.label;
    final Widget label;
    if (type == LabelChipType.tag) {
      label = SizedBox(
        height: 24,
        child: Center(
          widthFactor: 1,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '#',
                  style: style.copyWith(color: AppColors.black3),
                ),
                TextSpan(text: text),
              ],
            ),
            style: style.copyWith(color: AppColors.black),
          ),
        ),
      );
    } else {
      final (background, foreground) = switch (type) {
        LabelChipType.blue => (AppColors.blue, AppColors.white),
        LabelChipType.skyblue => (AppColors.lightblue2, AppColors.blue),
        _ => (AppColors.white, AppColors.blue),
      };
      label = Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(text, style: style.copyWith(color: foreground)),
        ),
      );
    }
    if (onTap == null) return label;
    return GestureDetector(onTap: onTap, child: label);
  }
}
