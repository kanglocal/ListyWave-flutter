import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/theme/app_theme.dart';
import 'package:listywave_app/core/theme/colors.dart';
import 'package:listywave_app/core/theme/typography.dart';

void main() {
  test('리스트 배경 팔레트는 web BACKGROUND_COLOR_READ 와 같은 24개 colorID 다', () {
    expect(ListBackgroundColors.read.length, 24);
    expect(ListBackgroundColors.read['PASTEL_PINK'], const Color(0xFFFFE0EA));
    expect(
      ListBackgroundColors.read['GRAY_MEDIUM_BLUE'],
      const Color(0xFFACBAC3),
    );
    expect(ListBackgroundColors.read['NEON_PURPLE'], const Color(0xFFE6C6FF));
  });

  test('타이포는 1rem = 10 으로 환산한다 (web font.css.ts)', () {
    const t = AppTypography.standard;
    expect((t.header.fontSize, t.header.letterSpacing), (20, -0.6));
    expect((t.bodyBold.fontSize, t.bodyBold.fontWeight), (16, FontWeight.w600));
    expect(t.labelSmall.letterSpacing, 0.6);
  });

  test('테마는 Pretendard 와 AppTypography extension 을 쓴다', () {
    final theme = AppTheme.light();
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Pretendard');
    expect(theme.extension<AppTypography>(), same(AppTypography.standard));
    expect(theme.colorScheme.primary, AppColors.blue);
  });
}
