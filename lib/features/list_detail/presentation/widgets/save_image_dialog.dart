import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/share/share_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// web `SaveImageModal.tsx`: 리스트를 카드 이미지로 미리 보이고 갤러리에 저장한다
/// (RepaintBoundary → PNG → gal, PLAN §6).
Future<void> showSaveImageDialog(
  BuildContext context, {
  required ListDetailType list,
}) => showDialog<void>(
  context: context,
  useRootNavigator: true,
  builder: (_) => SaveImageDialog(list: list),
);

class SaveImageDialog extends ConsumerStatefulWidget {
  const SaveImageDialog({super.key, required this.list});

  final ListDetailType list;

  @override
  ConsumerState<SaveImageDialog> createState() => _SaveImageDialogState();
}

class _SaveImageDialogState extends ConsumerState<SaveImageDialog> {
  final _boundaryKey = GlobalKey();
  bool _saving = false;

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    String message;
    try {
      final boundary =
          _boundaryKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      await ref
          .read(shareServiceProvider)
          .saveImageToGallery(
            bytes!.buffer.asUint8List(),
            name: 'listywave_${DateTime.now().millisecondsSinceEpoch}',
          );
      message = l10n.toast_saveImageSuccess;
      navigator.pop();
    } on SaveImageException catch (e) {
      message = e.failure == SaveImageFailure.accessDenied
          ? l10n.toast_saveImagePermissionDenied
          : l10n.toast_saveImageFailed;
    } on Object {
      message = l10n.toast_saveImageFailed;
    }
    if (mounted) setState(() => _saving = false);
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final list = widget.list;
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: _boundaryKey,
                  child: _ListImageCard(list: list),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.common_cancel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    key: const Key('saveImage.save'),
                    onPressed: _saving ? null : _save,
                    child: Text(l10n.listDetail_saveImage),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 저장되는 카드. 배경색과 순위/제목, 작성자를 담는다.
class _ListImageCard extends StatelessWidget {
  const _ListImageCard({required this.list});

  final ListDetailType list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            ListBackgroundColors.read[list.backgroundColor] ?? AppColors.bggray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.categoryKorName,
            style: context.typo.labelSmall.copyWith(color: AppColors.blue),
          ),
          const SizedBox(height: 6),
          Text(list.title, style: context.typo.subtitle),
          const SizedBox(height: 12),
          for (final item in list.items)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
              child: Text(
                '${item.rank}. ${item.title}',
                style: context.typo.body,
              ),
            ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${list.ownerNickname} · ListyWave',
              style: context.typo.labelSmall.copyWith(color: AppColors.gray),
            ),
          ),
        ],
      ),
    );
  }
}
