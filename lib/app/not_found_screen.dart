import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/l10n/gen/app_localizations.dart';
import '../core/theme/colors.dart';
import '../core/widgets/no_data.dart';
import 'router.dart';

/// 등록되지 않은 경로 (잘못된 deeplink 포함) 에서 보이는 화면 (go_router errorBuilder).
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: NoDataView(
              key: const Key('notFound'),
              message: l10n.notFound_message,
              description: l10n.notFound_description,
              buttonLabel: l10n.notFound_goHome,
              onButtonPressed: () => context.go(AppRoutes.home),
            ),
          ),
        ),
      ),
    );
  }
}
