import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

/// web `DeleteModal` / `ConfirmBottomSheet`. 확인을 누르면 true 다.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String message,
  String? description,
  String? confirmLabel,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    useRootNavigator: true,
    // web `Modal` basic (흰색, radius 8, padding 24, 사이 24) + `Modal.Title` (BodyRegular) +
    // `Modal.Button` (오른쪽 정렬, 사이 16, padding 10 16, radius 12; 취소 whiteblue, 확인 blue).
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 52),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 270),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                message,
                style: context.typo.bodyRegular.copyWith(
                  color: AppColors.black,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description,
                  style: context.typo.label.copyWith(color: AppColors.gray),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    key: const Key('confirmDialog.cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                    style: modalButtonStyle(context, primary: false),
                    child: Text(l10n.common_cancel),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    key: const Key('confirmDialog.confirm'),
                    onPressed: () => Navigator.of(context).pop(true),
                    style: modalButtonStyle(context, primary: true),
                    child: Text(confirmLabel ?? l10n.common_confirm),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return result ?? false;
}

/// web `ModalButton.css.ts`: Label, padding 10 16, radius 12. primary 는 blue 바탕 흰 글자,
/// secondary 는 whiteblue 바탕 blue 글자, 비활성은 흰 바탕 bluegray8.
ButtonStyle modalButtonStyle(BuildContext context, {required bool primary}) =>
    TextButton.styleFrom(
      backgroundColor: primary ? AppColors.blue : AppColors.whiteblue,
      foregroundColor: primary ? AppColors.white : AppColors.blue,
      disabledBackgroundColor: AppColors.white,
      disabledForegroundColor: AppColors.bluegray8,
      minimumSize: const Size(0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: context.typo.label,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
