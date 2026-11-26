import 'package:flutter/painting.dart';

/// web `src/styles/theme.css.ts` 의 `vars.color` (21개).
abstract final class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const lightblue = Color(0xFFE5EEFE);
  static const lightblue2 = Color(0xFFE3EEFF);
  static const whiteblue = Color(0xFFEEF6FF);
  static const skyblue = Color(0xFFC5DFFF);
  static const blue = Color(0xFF3D95FF);
  static const deepblue8 = Color(0xFF6A7DA1);
  static const deepblue10 = Color(0xFF3C4F76);
  static const bluegray6 = Color(0xFFB6C2CE);
  static const bluegray8 = Color(0xFF8599AD);
  static const bluegray10 = Color(0xFF637587);
  static const lightgray = Color(0xFFB6BBBF);
  static const gray = Color(0xFF7A7B7D);
  static const gray2 = Color(0xFF676B75);
  static const gray3 = Color(0xFF556575);
  static const gray4 = Color(0xFF707681);
  static const bggray = Color(0xFFF5F6FA);
  static const black = Color(0xFF323A43);
  static const black2 = Color(0xFF213752);
  static const black3 = Color(0xFF3E4455);
  static const red = Color(0xFFFF0000);
}

/// web `src/styles/Color.ts` `BACKGROUND_COLOR_PALETTE_TYPE`.
enum BackgroundPalette { pastel, vivid, neon, gray }

/// 리스트 배경색 하나. [id] 는 서버에 저장되는 colorID 다.
class ListBackgroundColor {
  const ListBackgroundColor(this.id, this.color);

  final String id;
  final Color color;
}

/// web `src/styles/Color.ts` `BACKGROUND_COLOR_CREATE` / `BACKGROUND_COLOR_READ`.
abstract final class ListBackgroundColors {
  static const Map<BackgroundPalette, List<ListBackgroundColor>> create = {
    BackgroundPalette.pastel: [
      ListBackgroundColor('PASTEL_PINK', Color(0xFFFFE0EA)),
      ListBackgroundColor('PASTEL_ORANGE', Color(0xFFFFEBCB)),
      ListBackgroundColor('PASTEL_YELLOW', Color(0xFFFFFFDA)),
      ListBackgroundColor('PASTEL_GREEN', Color(0xFFD9FFD4)),
      ListBackgroundColor('PASTEL_SKYBLUE', Color(0xFFE0F8FF)),
      ListBackgroundColor('PASTEL_PURPLE', Color(0xFFE4E0FF)),
    ],
    BackgroundPalette.vivid: [
      ListBackgroundColor('VIVID_RED', Color(0xFFFF8080)),
      ListBackgroundColor('VIVID_ORANGE', Color(0xFFFCCA8D)),
      ListBackgroundColor('VIVID_YELLOW', Color(0xFFFFF4AA)),
      ListBackgroundColor('VIVID_GREEN', Color(0xFF96EDA0)),
      ListBackgroundColor('VIVID_BLUE', Color(0xFF80AAFF)),
      ListBackgroundColor('VIVID_PURPLE', Color(0xFF9E6AFF)),
    ],
    BackgroundPalette.neon: [
      ListBackgroundColor('NEON_WHITE', Color(0xFFFFFFFF)),
      ListBackgroundColor('NEON_YELLOW', Color(0xFFFFF6A5)),
      ListBackgroundColor('NEON_ORANGE', Color(0xFFFFDCB2)),
      ListBackgroundColor('NEON_GREEN', Color(0xFFD0FF89)),
      ListBackgroundColor('NEON_BLUE', Color(0xFFB7EEFF)),
      ListBackgroundColor('NEON_PURPLE', Color(0xFFE6C6FF)),
    ],
    BackgroundPalette.gray: [
      ListBackgroundColor('GRAY_VERYLIGHT', Color(0xFFF9F9F9)),
      ListBackgroundColor('GRAY_LIGHT', Color(0xFFDEDEDE)),
      ListBackgroundColor('GRAY_MEDIUM', Color(0xFFA4A4A4)),
      ListBackgroundColor('GRAY_SOFT_BLUE', Color(0xFFE2E7EB)),
      ListBackgroundColor('GRAY_LIGHT_BLUE', Color(0xFFC8CFD5)),
      ListBackgroundColor('GRAY_MEDIUM_BLUE', Color(0xFFACBAC3)),
    ],
  };

  /// colorID → 색. 서버 응답의 `backgroundColor` 를 그릴 때 쓴다.
  static final Map<String, Color> read = {
    for (final palette in create.values)
      for (final c in palette) c.id: c.color,
  };
}

/// web `src/lib/constants/exploreListBackgroundColor.ts`.
const List<Color> exploreBackgroundColors = [
  Color(0xFFC9E5FF),
  Color(0xFFCEF2FF),
  Color(0xFFD8F0FF),
  Color(0xFFDEE7FF),
  Color(0xFFDAEBFF),
];
