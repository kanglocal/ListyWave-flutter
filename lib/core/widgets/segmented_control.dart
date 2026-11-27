import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

/// [SegmentedControl] 의 선택지 하나.
class Segment<T> {
  const Segment({required this.value, required this.label, this.key});

  final T value;
  final String label;
  final Key? key;
}

/// web `src/components/SegmentedControl` (3.0): `bggray` track (padding 2, radius 12, gap 5) 위에
/// 고른 segment 만 흰색 (padding 10 20, radius 12).
class SegmentedControl<T> extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.expand = false,
    this.trackColor = AppColors.bggray,
    this.selectedColor = AppColors.white,
  });

  final List<Segment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  /// true 면 가로를 꽉 채우고 segment 를 같은 폭으로 나눈다.
  final bool expand;
  final Color trackColor;

  /// 고른 segment 바탕. track 이 흰색이면 (bggray 화면 위) [AppColors.lightblue] 를 준다.
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    final children = <Widget>[];
    for (final (i, s) in segments.indexed) {
      if (i > 0) children.add(const SizedBox(width: 5));
      final isSelected = s.value == selected;
      final segment = Semantics(
        button: true,
        selected: isSelected,
        child: Material(
          key: s.key,
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: () => onChanged(s.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                s.label,
                textAlign: TextAlign.center,
                style: context.typo.labelBold.copyWith(color: AppColors.black),
              ),
            ),
          ),
        ),
      );
      children.add(expand ? Expanded(child: segment) : segment);
    }
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: trackColor, borderRadius: radius),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: children,
      ),
    );
  }
}
