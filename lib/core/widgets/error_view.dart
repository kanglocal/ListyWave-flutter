import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';
import '../network/app_exception.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

/// 조회 실패 화면. backend `ErrorResponse.message` 가 있으면 그것을 보여준다.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exception = AppException.from(error);
    final message = exception.status == null
        ? l10n.error_network
        : l10n.error_loadFailed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.typo.bodyBold.copyWith(color: AppColors.black),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: Text(l10n.error_retry)),
          ],
        ],
      ),
    );
  }
}
