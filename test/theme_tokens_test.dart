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

  test('3.0 구분선 토큰 line 은 web theme.css.ts 의 #DEE2EE 다', () {
    expect(AppColors.line, const Color(0xFFDEE2EE));
  });

  test('테마는 web 3.0 처럼 bggray 바탕에 높이 50 헤더를 쓰고 M3 tint 를 끈다', () {
    final theme = AppTheme.light();
    expect(theme.scaffoldBackgroundColor, AppColors.bggray);
    expect(theme.appBarTheme.toolbarHeight, 50);
    expect(theme.appBarTheme.backgroundColor, AppColors.bggray);
    expect(theme.appBarTheme.surfaceTintColor, Colors.transparent);
    expect(theme.dialogTheme.backgroundColor, AppColors.white);
    expect(theme.dialogTheme.surfaceTintColor, Colors.transparent);
  });

  test('테마는 Pretendard 와 AppTypography extension 을 쓴다', () {
    final theme = AppTheme.light();
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Pretendard');
    expect(theme.extension<AppTypography>(), same(AppTypography.standard));
    expect(theme.colorScheme.primary, AppColors.blue);
  });
}
