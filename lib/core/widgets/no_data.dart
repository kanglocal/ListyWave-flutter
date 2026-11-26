import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

/// web `src/components/NoData/NoDataComponent.tsx`.
class NoDataView extends StatelessWidget {
  const NoDataView({
    super.key,
    required this.message,
    this.image,
    this.description,
    this.buttonLabel,
    this.onButtonPressed,
  });

  final String message;
  final Widget? image;
  final String? description;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[image!, const SizedBox(height: 16)],
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.typo.bodyBold.copyWith(color: AppColors.black),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
          ],
          if (buttonLabel != null) ...[
            const SizedBox(height: 20),
            NoDataButton(label: buttonLabel!, onPressed: onButtonPressed),
          ],
        ],
      ),
    );
  }
}

/// web `NoDataButton.tsx`.
class NoDataButton extends StatelessWidget {
  const NoDataButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: context.typo.labelBold,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
