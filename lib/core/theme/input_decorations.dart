import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

/// web 3.0 입력칸 (`list/create/_components/Step.css.ts` inputDiv): `bggray` 바탕 위의 흰 박스,
/// padding 12 16, radius 12, 테두리 없음. 글자는 `BodyRegular` `bluegray10`, placeholder 는 `bluegray6`.
/// bottom sheet 처럼 흰 바탕 위에서는 [fill] 로 `bggray` 를 준다 (web `contentInput`).
InputDecoration listyInputDecoration(
  BuildContext context, {
  String? hintText,
  String? errorText,
  String? counterText,
  Color fill = AppColors.white,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  );
  return InputDecoration(
    hintText: hintText,
    hintStyle: context.typo.bodyRegular.copyWith(color: AppColors.bluegray6),
    errorText: errorText,
    errorStyle: context.typo.label.copyWith(color: AppColors.red),
    counterText: counterText,
    counterStyle: context.typo.bodyRegular.copyWith(color: AppColors.bluegray6),
    filled: true,
    fillColor: fill,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    errorBorder: border,
    focusedErrorBorder: border,
  );
}

/// [listyInputDecoration] 에 맞는 입력 글자.
TextStyle listyInputText(BuildContext context) =>
    context.typo.bodyRegular.copyWith(color: AppColors.bluegray10);
