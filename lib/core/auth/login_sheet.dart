import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';
import '../theme/typography.dart';

/// web `src/components/login/LoginModal.tsx` 자리. `/login` dialog page 로 뜬다.
class LoginSheet extends StatelessWidget {
  const LoginSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: const Text('LoginSheet'),
      content: Text(l10n.common_signInAndUp, style: context.typo.bodyRegular),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.common_close),
        ),
      ],
    );
  }
}
