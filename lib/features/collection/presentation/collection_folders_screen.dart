import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/folder_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/error_view.dart';
import '../application/collection_providers.dart';
import 'widgets/folder_actions.dart';

/// web `/collection`: "전체" + 내 폴더 목록, 폴더 추가. 폴더마다 이름 바꾸기/삭제 메뉴를 둔다
/// (web 은 폴더 상세에만 있다).
class CollectionFoldersScreen extends ConsumerWidget {
  const CollectionFoldersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final folders = ref.watch(foldersProvider);
    final list = folders.value;

    final Widget body;
    if (list == null && folders.hasError) {
      body = ErrorView(
        error: folders.error!,
        onRetry: () => ref.invalidate(foldersProvider),
      );
    } else if (list == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      final all = [
        FoldersType(
          folderId: entireFolderId,
          folderName: l10n.collection_entire,
          listCount: 0,
        ),
        ...list,
      ];
      body = RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(foldersProvider);
          await ref.read(foldersProvider.future);
        },
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: all.length,
          itemBuilder: (context, index) => _FolderTile(folder: all[index]),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.collection_title, style: context.typo.bodyBold),
      ),
      body: body,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: OutlinedButton.icon(
            key: const Key('collection.addFolder'),
            onPressed: () => createFolder(context, ref),
            icon: const Icon(Icons.add, color: AppColors.blue),
            label: Text(l10n.collect_addFolder),
          ),
        ),
      ),
    );
  }
}

enum _FolderMenu { rename, delete }

class _FolderTile extends ConsumerWidget {
  const _FolderTile({required this.folder});

  final FoldersType folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isEntire = folder.folderId == entireFolderId;
    return Material(
      color: AppColors.bggray,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        key: Key('collection.folder.${folder.folderId}'),
        borderRadius: BorderRadius.circular(16),
        onTap: () =>
            context.push(AppRoutes.collectionFolder('${folder.folderId}')),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.folder_rounded,
                    size: 48,
                    color: AppColors.skyblue,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      folder.listCount > 0
                          ? '${folder.folderName} (${folder.listCount})'
                          : folder.folderName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typo.bodyBold,
                    ),
                  ),
                ],
              ),
            ),
            if (!isEntire)
              Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton<_FolderMenu>(
                  key: Key('collection.folderMenu.${folder.folderId}'),
                  tooltip: l10n.collection_folderMenu,
                  onSelected: (menu) => switch (menu) {
                    _FolderMenu.rename => renameFolder(
                      context,
                      ref,
                      folderId: folder.folderId,
                      currentName: folder.folderName,
                    ),
                    _FolderMenu.delete => deleteFolder(
                      context,
                      ref,
                      folderId: folder.folderId,
                    ),
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      key: const Key('collection.menu.rename'),
                      value: _FolderMenu.rename,
                      child: Text(l10n.collection_renameFolder),
                    ),
                    PopupMenuItem(
                      key: const Key('collection.menu.delete'),
                      value: _FolderMenu.delete,
                      child: Text(l10n.collection_deleteFolder),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
