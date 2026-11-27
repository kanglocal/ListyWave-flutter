import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/list_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/infinite_scroll.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/simple_list.dart';
import '../application/collection_providers.dart';
import 'widgets/folder_actions.dart';

enum _FolderMenu { rename, delete }

/// web `/collection/[folderId]`: 폴더 안 콜렉트 리스트 (infinite grid), 이름 바꾸기/삭제.
/// folderId 0 은 모든 폴더를 합친 "전체" 라 메뉴가 없다.
class CollectionFolderScreen extends ConsumerWidget {
  const CollectionFolderScreen({super.key, required this.folderId});

  final String folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(folderId);
    if (id == null) {
      return Scaffold(
        appBar: AppBar(),
        body: NoDataView(message: l10n.collection_noCollection),
      );
    }
    final isEntire = id == entireFolderId;
    final folders = ref.watch(foldersProvider).value;
    final folderName = isEntire
        ? l10n.collection_entire
        : folders?.where((f) => f.folderId == id).firstOrNull?.folderName ?? '';
    final collection = ref.watch(collectionProvider(id));
    final page = collection.value;

    Future<void> onMenu(_FolderMenu menu) async {
      switch (menu) {
        case _FolderMenu.rename:
          await renameFolder(
            context,
            ref,
            folderId: id,
            currentName: folderName,
          );
        case _FolderMenu.delete:
          final router = GoRouter.of(context);
          if (await deleteFolder(context, ref, folderId: id)) {
            router.canPop() ? router.pop() : router.go(AppRoutes.collection);
          }
      }
    }

    final Widget body;
    if (page == null && collection.hasError) {
      body = ErrorView(
        error: collection.error!,
        onRetry: () => ref.invalidate(collectionProvider(id)),
      );
    } else if (page == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (page.items.isEmpty) {
      body = NoDataView(
        message: l10n.collection_noCollection,
        buttonLabel: l10n.common_back,
        onButtonPressed: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.collection),
      );
    } else {
      body = InfiniteScroll(
        canLoadMore: page.hasNext && !page.isLoadingMore,
        onLoadMore: () => ref.read(collectionProvider(id).notifier).loadMore(),
        child: RefreshIndicator(
          onRefresh: () => ref.read(collectionProvider(id).notifier).refresh(),
          child: MasonryGridView.count(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: page.items.length,
            itemBuilder: (context, index) =>
                _CollectedListCard(list: page.items[index].list),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(folderName, style: context.typo.bodyBold),
        actions: [
          if (!isEntire)
            PopupMenuButton<_FolderMenu>(
              key: const Key('collection.detailMenu'),
              tooltip: l10n.collection_folderMenu,
              onSelected: onMenu,
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
        ],
      ),
      body: body,
    );
  }
}

/// web `ShapeSimpleList`. 대표 이미지가 있으면 위에 보인다.
class _CollectedListCard extends StatelessWidget {
  const _CollectedListCard({required this.list});

  final CollectionListType list;

  @override
  Widget build(BuildContext context) {
    final image = list.representativeImageUrl;
    return GestureDetector(
      key: Key('collection.list.${list.id}'),
      onTap: () => context.push(AppRoutes.listDetail('${list.id}')),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color:
              ListBackgroundColors.read[list.backgroundColor] ??
              AppColors.bggray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (image != null && image.isNotEmpty)
              AspectRatio(aspectRatio: 1.4, child: AppNetworkImage(url: image)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.category,
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    list.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typo.bodyBold,
                  ),
                  const SizedBox(height: 4),
                  SimpleRankList(
                    items: [
                      for (final item in list.listItems.take(3))
                        (rank: item.rank, title: item.title),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    list.ownerNickname,
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray,
                    ),
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
