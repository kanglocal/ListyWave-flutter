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
      // web `components/NoData/NoData.css.ts`: padding 55 0, 메시지 18/600 deepblue10,
      // 설명 LabelSmall, 버튼은 흰 pill 에 blue 30% 테두리.
      padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[image!, const SizedBox(height: 16)],
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.typo.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.6,
              letterSpacing: -0.54,
              color: AppColors.deepblue10,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: context.typo.labelSmall.copyWith(color: AppColors.black),
            ),
          ],
          if (buttonLabel != null) ...[
            const SizedBox(height: 16),
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
      // web `NoDataButton.css.ts`: 흰 바탕, 1px #3D95FF4D, pill, blue 14, padding 7 14.
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.blue,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        side: const BorderSide(color: Color(0x4D3D95FF)),
        shape: const StadiumBorder(),
        textStyle: context.typo.label,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
