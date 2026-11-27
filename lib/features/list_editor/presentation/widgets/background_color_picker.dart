import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// web StepThree 배경 색상: 팔레트 탭을 고르고 그 팔레트의 색을 누르면 둘 다 정해진다.
class BackgroundColorPicker extends StatefulWidget {
  const BackgroundColorPicker({
    super.key,
    required this.palette,
    required this.color,
    required this.onChanged,
  });

  final BackgroundPalette palette;

  /// backend `BackgroundColor` 이름.
  final String color;
  final void Function(BackgroundPalette palette, String color) onChanged;

  @override
  State<BackgroundColorPicker> createState() => _BackgroundColorPickerState();
}

class _BackgroundColorPickerState extends State<BackgroundColorPicker> {
  /// 보고 있는 팔레트 탭. 색을 누르기 전에는 선택 값을 바꾸지 않는다 (web 과 같음).
  late BackgroundPalette _tab = widget.palette;

  @override
  Widget build(BuildContext context) {
    final colors = ListBackgroundColors.create[_tab]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 8,
                children: [
                  for (final palette in BackgroundPalette.values)
                    ChoiceChip(
                      key: Key('editor.palette.${palette.name}'),
                      label: Text(palette.name.toUpperCase()),
                      selected: palette == _tab,
                      showCheckmark: false,
                      selectedColor: AppColors.blue,
                      labelStyle: context.typo.labelSmall.copyWith(
                        color: palette == _tab
                            ? AppColors.white
                            : AppColors.gray3,
                      ),
                      onSelected: (_) => setState(() => _tab = palette),
                    ),
                ],
              ),
            ),
            Container(
              key: const Key('editor.colorPreview'),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: ListBackgroundColors.read[widget.color],
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bluegray6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final c in colors)
              Semantics(
                button: true,
                selected: c.id == widget.color,
                label: c.id,
                child: GestureDetector(
                  key: Key('editor.color.${c.id}'),
                  onTap: () => widget.onChanged(_tab, c.id),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: c.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bluegray6),
                    ),
                    child: c.id == widget.color
                        ? const Icon(Icons.check, color: AppColors.deepblue10)
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
