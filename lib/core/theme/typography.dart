import 'package:flutter/material.dart';

/// web `src/styles/font.css.ts`. web html 은 `font-size: 62.5%` 라 1rem = 10px 이다
/// (`GlobalStyles.css.ts`). 그래서 `2rem → 20`, `-0.06rem → -0.6` 으로 옮긴다.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.header,
    required this.subtitle,
    required this.bodyBold,
    required this.bodyRegular,
    required this.body,
    required this.labelBold,
    required this.label,
    required this.labelSmall,
  });

  static const fontFamily = 'Pretendard';

  static const standard = AppTypography(
    header: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.6,
    ),
    subtitle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.54,
    ),
    bodyBold: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.54,
    ),
    bodyRegular: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    ),
    body: TextStyle(
      fontFamily: fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    ),
    labelBold: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.42,
    ),
    label: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.42,
    ),
    // web 은 300(Light) 이다. Light 는 번들하지 않으므로 Regular 로 그려진다.
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 16 / 12,
      letterSpacing: 0.6,
    ),
  );

  final TextStyle header;
  final TextStyle subtitle;
  final TextStyle bodyBold;
  final TextStyle bodyRegular;
  final TextStyle body;
  final TextStyle labelBold;
  final TextStyle label;
  final TextStyle labelSmall;

  @override
  AppTypography copyWith({
    TextStyle? header,
    TextStyle? subtitle,
    TextStyle? bodyBold,
    TextStyle? bodyRegular,
    TextStyle? body,
    TextStyle? labelBold,
    TextStyle? label,
    TextStyle? labelSmall,
  }) => AppTypography(
    header: header ?? this.header,
    subtitle: subtitle ?? this.subtitle,
    bodyBold: bodyBold ?? this.bodyBold,
    bodyRegular: bodyRegular ?? this.bodyRegular,
    body: body ?? this.body,
    labelBold: labelBold ?? this.labelBold,
    label: label ?? this.label,
    labelSmall: labelSmall ?? this.labelSmall,
  );

  @override
  AppTypography lerp(AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      header: TextStyle.lerp(header, other.header, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      bodyBold: TextStyle.lerp(bodyBold, other.bodyBold, t)!,
      bodyRegular: TextStyle.lerp(bodyRegular, other.bodyRegular, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      labelBold: TextStyle.lerp(labelBold, other.labelBold, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

extension AppTypographyContext on BuildContext {
  AppTypography get typo => Theme.of(this).extension<AppTypography>()!;
}
