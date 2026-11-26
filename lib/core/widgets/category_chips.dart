import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../category/category_api.dart';
import '../models/categories_type.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

/// 가로 카테고리 버튼 (web 홈 `Categories.tsx`, 유저 `Categories.tsx`, 검색 `CategoryArea.tsx`).
/// 선택 값은 [selectedEngName] 또는 [selectedCode] 중 하나로 비교한다.
class CategoryChips extends ConsumerWidget {
  const CategoryChips({
    super.key,
    required this.onSelected,
    this.selectedEngName,
    this.selectedCode,
    this.useEnglishName = false,
  });

  final ValueChanged<CategoryType> onSelected;
  final String? selectedEngName;
  final String? selectedCode;

  /// web 검색 화면은 언어가 en 이면 engName 을 보인다.
  final bool useEnglishName;

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
    return SizedBox(
      height: 52,
      child: Skeletonizer(
        enabled: categories.value == null,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = items[index];
            final selected = _isSelected(category);
            return ChoiceChip(
              key: Key('category.${category.code}'),
              label: Text(useEnglishName ? category.engName : category.korName),
              selected: selected,
              showCheckmark: false,
              onSelected: (_) => onSelected(category),
              labelStyle: context.typo.label.copyWith(
                color: selected ? AppColors.white : AppColors.gray3,
              ),
              selectedColor: AppColors.blue,
              backgroundColor: AppColors.white,
              side: BorderSide(
                color: selected ? AppColors.blue : AppColors.bluegray6,
              ),
              shape: const StadiumBorder(),
            );
          },
        ),
      ),
    );
  }
}
