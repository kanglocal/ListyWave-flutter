import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/validation/validators.dart';

/// 폴더 이름 입력 (web 콜렉션 "새로운 폴더" / "폴더 이름 바꾸기" bottom sheet).
/// 확인을 누르면 입력값을, 취소하면 null 을 돌려준다.
Future<String?> showFolderNameDialog(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String initial = '',
}) => showDialog<String>(
  context: context,
  builder: (_) => FolderNameDialog(
    title: title,
    confirmLabel: confirmLabel,
    initial: initial,
  ),
);

class FolderNameDialog extends StatefulWidget {
  const FolderNameDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.initial = '',
  });

  final String title;
  final String confirmLabel;
  final String initial;

  @override
  State<FolderNameDialog> createState() => _FolderNameDialogState();
}

class _FolderNameDialogState extends State<FolderNameDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        key: const Key('collect.folderName'),
        controller: _controller,
        autofocus: true,
        inputFormatters: [LengthLimitingTextInputFormatter(folderNameMax)],
        decoration: InputDecoration(hintText: l10n.collect_folderNameHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.common_cancel),
        ),
        TextButton(
          key: const Key('collect.createFolder'),
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
