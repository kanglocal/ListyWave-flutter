import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

enum LabelChipType { blue, skyblue, white, tag }

/// web `src/components/Label/Label.tsx`.
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
    final (background, foreground) = switch (type) {
      LabelChipType.blue => (AppColors.blue, AppColors.white),
      LabelChipType.skyblue => (AppColors.skyblue, AppColors.blue),
      LabelChipType.white => (AppColors.white, AppColors.blue),
      LabelChipType.tag => (AppColors.white, AppColors.blue),
    };
    final label = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: type == LabelChipType.tag
            ? Border.all(color: AppColors.skyblue)
            : null,
      ),
      child: Text(
        type == LabelChipType.tag ? '#$text' : text,
        style: context.typo.label.copyWith(color: foreground, fontSize: 13),
      ),
    );
    if (onTap == null) return label;
    return GestureDetector(onTap: onTap, child: label);
  }
}
