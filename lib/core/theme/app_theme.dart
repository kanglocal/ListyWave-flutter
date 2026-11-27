import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

/// web 3.0 은 모든 페이지가 `bggray` 바탕에 흰 카드다 (`src/app/layout.css.ts`).
/// Material 3 의 surface tint 는 web 에 없으므로 끈다.
abstract final class AppTheme {
  /// web `Header.css.ts` 의 높이.
  static const headerHeight = 50.0;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: AppColors.blue,
      surface: AppColors.white,
      onSurface: AppColors.black,
      surfaceTint: Colors.transparent,
      outline: AppColors.line,
      outlineVariant: AppColors.line,
      error: AppColors.red,
    );
    const typo = AppTypography.standard;
    const transparent = Colors.transparent;
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppTypography.fontFamily,
      scaffoldBackgroundColor: AppColors.bggray,
      dividerColor: AppColors.line,
      extensions: const [typo],
      appBarTheme: AppBarTheme(
        toolbarHeight: headerHeight,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bggray,
        surfaceTintColor: transparent,
        foregroundColor: AppColors.black,
        titleTextStyle: typo.subtitle.copyWith(color: AppColors.black),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      // web `Modal.css.ts` basic: 흰색, radius 8, padding 24.
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: transparent,
        barrierColor: AppColors.barrier,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titleTextStyle: typo.bodyRegular.copyWith(color: AppColors.black),
        contentTextStyle: typo.bodyRegular.copyWith(color: AppColors.black),
      ),
      // web `BottomSheet.css.ts`: 흰색, 위 모서리 25, dimmed 0.3.
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: transparent,
        modalBarrierColor: Color(0x4D000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.white,
        surfaceTintColor: transparent,
        textStyle: typo.label.copyWith(color: AppColors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      // web `ModalButton.css.ts`: Label, padding 10 16, radius 12.
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blue,
          textStyle: typo.labelBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.bluegray6,
          disabledForegroundColor: AppColors.white,
          textStyle: typo.bodyBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      // web `collection/page.css.ts` addFolderButton / `NoticeDetailContents` button.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.blue,
          side: const BorderSide(color: Color(0x803D95FF)),
          textStyle: typo.bodyBold.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.black,
        contentTextStyle: typo.labelBold.copyWith(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.blue,
      ),
    );
  }
}
