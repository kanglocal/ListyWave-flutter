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
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.typo.bodyBold,
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          key: const Key('confirmDialog.cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.common_cancel),
        ),
        TextButton(
          key: const Key('confirmDialog.confirm'),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmLabel ?? l10n.common_confirm,
            style: const TextStyle(color: AppColors.red),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}
