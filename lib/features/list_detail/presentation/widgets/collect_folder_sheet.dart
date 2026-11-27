import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/toast.dart';
import '../../../collection/application/collection_providers.dart';
import '../../../collection/data/folder_api.dart';
import '../../../collection/presentation/widgets/folder_name_dialog.dart';

/// 콜렉트할 폴더를 고르는 bottom sheet (web `CollectFolderSheet.tsx`, PLAN §11 Q1).
/// 마지막으로 쓴 폴더를 기본 선택하고, 폴더가 없으면 새 폴더를 만들게 한다.
/// 고른 폴더 id 를 돌려주고, 닫으면 null 이다.
Future<int?> showCollectFolderSheet(BuildContext context) =>
    showModalBottomSheet<int>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const CollectFolderSheet(),
    );

class CollectFolderSheet extends ConsumerStatefulWidget {
  const CollectFolderSheet({super.key});

  @override
  ConsumerState<CollectFolderSheet> createState() => _CollectFolderSheetState();
}

class _CollectFolderSheetState extends ConsumerState<CollectFolderSheet> {
  int? _selected;
  int? _lastUsed;
  bool _creating = false;

  @override
  void initState() {
    super.initState();
    ref.read(lastCollectFolderStoreProvider).read().then((id) {
      if (mounted) setState(() => _lastUsed = id);
    });
  }

  Future<void> _createFolder() async {
    final l10n = AppLocalizations.of(context);
    final name = await showFolderNameDialog(
      context,
      title: l10n.collect_newFolder,
      confirmLabel: l10n.collect_create,
    );
    if (name == null || !mounted) return;
    if (name.trim().isEmpty) {
      showToast(context, l10n.toast_emptyFolderName);
      return;
    }
    setState(() => _creating = true);
    try {
      final id = await ref.read(folderApiProvider).createFolder(name.trim());
      ref.invalidate(foldersProvider);
      if (mounted) setState(() => _selected = id);
    } on Exception catch (e) {
      if (!mounted) return;
      final duplicated = AppException.from(e).code.startsWith('DUPLICATE');
      showToast(
        context,
        duplicated ? l10n.toast_duplicatedFolderName : l10n.toast_failedFolder,
      );
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final folders = ref.watch(foldersProvider);
    final list = folders.value;
    final selected =
        _selected ?? (list == null ? null : preferredFolderId(list, _lastUsed));

    final Widget body;
    if (list == null && folders.hasError) {
      body = ErrorView(
        error: folders.error!,
        onRetry: () => ref.invalidate(foldersProvider),
      );
    } else if (list == null) {
      body = const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (list.isEmpty) {
      body = Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          l10n.collect_noFolder,
          key: const Key('collect.noFolder'),
          textAlign: TextAlign.center,
          style: context.typo.body.copyWith(color: AppColors.gray),
        ),
      );
    } else {
      body = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.5,
        ),
        child: RadioGroup<int>(
          groupValue: selected,
          onChanged: (id) => setState(() => _selected = id),
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final folder in list)
                RadioListTile<int>(
                  key: Key('collect.folder.${folder.folderId}'),
                  value: folder.folderId,
                  title: Text(folder.folderName, style: context.typo.body),
                  subtitle: Text(
                    l10n.collect_listCount(folder.listCount),
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.collect_selectFolder, style: context.typo.subtitle),
          const SizedBox(height: 8),
          body,
          const SizedBox(height: 8),
          OutlinedButton(
            key: const Key('collect.addFolder'),
            onPressed: _creating ? null : _createFolder,
            child: Text(l10n.collect_addFolder),
          ),
          const SizedBox(height: 8),
          FilledButton(
            key: const Key('collect.confirm'),
            onPressed: selected == null || _creating
                ? null
                : () => Navigator.of(context).pop(selected),
            child: Text(l10n.listDetail_collect),
          ),
        ],
      ),
    );
  }
}
