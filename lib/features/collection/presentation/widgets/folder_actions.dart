import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/toast.dart';
import '../../application/collection_providers.dart';
import '../../data/folder_api.dart';
import 'folder_name_dialog.dart';

/// 폴더 이름을 받아 [request] 를 보낸다. 성공하면 true (web 콜렉션 create/edit mutation).
Future<bool> _submitFolderName(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  required String confirmLabel,
  required Future<void> Function(String name) request,
  String initial = '',
}) async {
  final l10n = AppLocalizations.of(context);
  final name = await showFolderNameDialog(
    context,
    title: title,
    confirmLabel: confirmLabel,
    initial: initial,
  );
  if (name == null || !context.mounted) return false;
  final error = validateFolderName(l10n, name);
  if (error != null) {
    showToast(context, error);
    return false;
  }
  try {
    await request(name.trim());
    ref.invalidate(foldersProvider);
    return true;
  } on Exception catch (e) {
    if (context.mounted) {
      final duplicated = AppException.from(e).code.startsWith('DUPLICATE');
      showToast(
        context,
        duplicated ? l10n.toast_duplicatedFolderName : l10n.toast_failedFolder,
      );
    }
    return false;
  }
}

/// `POST /folders {folderName}`.
Future<bool> createFolder(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  return _submitFolderName(
    context,
    ref,
    title: l10n.collect_newFolder,
    confirmLabel: l10n.collect_create,
    request: (name) => ref.read(folderApiProvider).createFolder(name),
  );
}

/// `PUT /folders/{folderId} {folderName}`.
Future<bool> renameFolder(
  BuildContext context,
  WidgetRef ref, {
  required int folderId,
  required String currentName,
}) {
  final l10n = AppLocalizations.of(context);
  return _submitFolderName(
    context,
    ref,
    title: l10n.collection_renameFolder,
    confirmLabel: l10n.common_confirm,
    initial: currentName,
    request: (name) async {
      await ref.read(folderApiProvider).updateFolder(folderId, name);
      ref.invalidate(collectionProvider(folderId));
    },
  );
}

/// 확인 뒤 `DELETE /folders/{folderId}`. 지웠으면 true.
Future<bool> deleteFolder(
  BuildContext context,
  WidgetRef ref, {
  required int folderId,
}) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showConfirmDialog(
    context,
    message: l10n.collection_deleteFolderConfirm,
    description: l10n.collection_deleteFolderDescription,
    confirmLabel: l10n.common_delete,
  );
  if (!confirmed || !context.mounted) return false;
  try {
    await ref.read(folderApiProvider).deleteFolder(folderId);
    ref
      ..invalidate(foldersProvider)
      ..invalidate(collectionProvider(entireFolderId));
    return true;
  } on Exception {
    if (context.mounted) showToast(context, l10n.toast_failedFolder);
    return false;
  }
}
