import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/folder_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/error_view.dart';
import '../application/collection_providers.dart';
import 'widgets/folder_actions.dart';
import '../../../core/widgets/listy_header.dart';

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
        // web `FolderList.css.ts` folders: padding 24 48 83, 2열, 사이 34 / 24.
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(48, 24, 48, 83),
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 34,
            mainAxisExtent: 136,
          ),
          itemCount: all.length,
          itemBuilder: (context, index) => _FolderTile(folder: all[index]),
        ),
      );
    }

    return Scaffold(
      appBar: ListyHeader(title: l10n.collection_title),
      body: body,
      // web `collection/page.css.ts` addFolderButton: padding 16 (바깥), 16 10 14 (안), 최대 358,
      // 흰 바탕 1px blue 50% 테두리, radius 18, blue 16/700, 아이콘 add.svg 16 (사이 10).
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 358),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  key: const Key('collection.addFolder'),
                  onPressed: () => createFolder(context, ref),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 14),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/new/add.svg',
                    width: 16,
                    height: 16,
                  ),
                  label: Text(l10n.collect_addFolder),
                ),
              ),
            ),
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
    // web `FolderList.tsx` Folder: 폴더 그림 아래 16 띄우고 Label 14 black 이름과 (개수).
    return InkWell(
      key: Key('collection.folder.${folder.folderId}'),
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
          context.push(AppRoutes.collectionFolder('${folder.folderId}')),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FolderIcon(),
                const SizedBox(height: 16),
                Text(
                  folder.listCount > 0
                      ? '${folder.folderName} (${folder.listCount})'
                      : folder.folderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
          if (!isEntire)
            Positioned(
              top: 18,
              right: 0,
              child: PopupMenuButton<_FolderMenu>(
                icon: const Icon(Icons.more_vert, color: AppColors.blue),
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
    );
  }
}

/// web `components/icons/FolderIcon` (130x96): 뒤는 #9CC9FF 탭+몸통, 앞은 #E3EEFF.
class FolderIcon extends StatelessWidget {
  const FolderIcon({super.key});

  static const _back = Color(0xFF9CC9FF);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 96,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: 66.62,
            height: 83.69,
            child: Container(
              // 탭 모양: 위 왼쪽 12, 위 오른쪽 23.
              decoration: BoxDecoration(
                color: _back,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                  right: Radius.circular(23),
                ).copyWith(bottomLeft: Radius.zero, bottomRight: Radius.zero),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            width: 130,
            height: 69.83,
            child: Container(
              decoration: const BoxDecoration(
                color: _back,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: 130,
            height: 76.83,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightblue2,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
