import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../category/category_api.dart';
import '../models/categories_type.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

/// 카테고리 버튼 (web 3.0 홈 `Categories.css.ts`, 유저 `Categories.css.ts`, 검색 `CategoryArea.css.ts`).
/// 테두리 없는 흰 pill 에 `bluegray8` 14/500 이고, 고르면 [selectedBackground] 바탕에 blue 다.
/// 홈과 검색은 줄바꿈([wrap]), 유저 화면은 가로 스크롤이다.
/// 선택 값은 [selectedEngName] 또는 [selectedCode] 중 하나로 비교한다.
class CategoryChips extends ConsumerWidget {
  const CategoryChips({
    super.key,
    required this.onSelected,
    this.selectedEngName,
    this.selectedCode,
    this.useEnglishName = false,
    this.wrap = false,
    this.spacing = 8,
    this.selectedBackground = AppColors.lightblue2,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
  });

  final ValueChanged<CategoryType> onSelected;
  final String? selectedEngName;
  final String? selectedCode;

  /// web 검색 화면은 언어가 en 이면 engName 을 보인다.
  final bool useEnglishName;
  final bool wrap;
  final double spacing;
  final Color selectedBackground;
  final EdgeInsets padding;

  bool _isSelected(CategoryType c) => selectedCode != null
      ? c.code == selectedCode
      : c.engName == selectedEngName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final items =
        categories.value ??
        [
          for (var i = 0; i < 6; i++)
            CategoryType(code: '$i', engName: 'category', korName: '카테고리'),
        ];
    if (categories.hasError && categories.value == null) {
      return const SizedBox.shrink();
    }
    final chips = [
      for (final category in items)
        CategoryChip(
          key: Key('category.${category.code}'),
          label: useEnglishName ? category.engName : category.korName,
          selected: _isSelected(category),
          selectedBackground: selectedBackground,
          onTap: () => onSelected(category),
        ),
    ];
    return Skeletonizer(
      enabled: categories.value == null,
      child: wrap
          ? Padding(
              padding: padding,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: chips,
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: padding,
              child: Row(
                children: [
                  for (final (i, chip) in chips.indexed) ...[
                    if (i > 0) SizedBox(width: spacing),
                    chip,
                  ],
                ],
              ),
            ),
    );
  }
}

/// web 3.0 카테고리 pill 하나 (padding 6 12, radius 20).
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedBackground = AppColors.lightblue2,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Color selectedBackground;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? selectedBackground : AppColors.white,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: context.typo.label.copyWith(
                fontWeight: FontWeight.w500,
                color: selected ? AppColors.blue : AppColors.bluegray8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
