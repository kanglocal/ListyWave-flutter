import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/toast.dart';
import '../../../list_detail/data/list_api.dart';
import '../../application/user_providers.dart';

/// web `user/[userId]/_components/Card.tsx`. 주인이면 공개 여부와 관리 메뉴
/// (`OptionToggleButton.tsx`: 공개/비공개 전환, 삭제), 아니면 카테고리를 보인다.
class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.list, required this.isOwner});

  final ListType list;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => context.push(AppRoutes.listDetail('${list.id}')),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              ListBackgroundColors.read[list.backgroundColor] ??
              AppColors.bggray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isOwner && !list.isPublic) ...[
                        SvgPicture.asset(
                          'assets/icons/new/lock.svg',
                          width: 12,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            AppColors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 3),
                      ],
                      Text(
                        isOwner
                            ? (list.isPublic
                                  ? l10n.listDetail_public
                                  : l10n.listDetail_private)
                            : list.category,
                        style: context.typo.labelSmall.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (isOwner) _OwnerMenu(list: list),
              ],
            ),
            const SizedBox(height: 10),
            Text(list.title, style: context.typo.bodyBold),
            const SizedBox(height: 8),
            for (final item in list.listItems)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Text(
                  '${item.rank}. ${item.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.copyWith(color: AppColors.gray3),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum _OwnerAction { visibility, delete }

/// web `OptionToggleButton.tsx`. 성공하면 마이리스트를 다시 읽는다.
class _OwnerMenu extends ConsumerWidget {
  const _OwnerMenu({required this.list});

  final ListType list;

  Future<void> _onSelected(
    BuildContext context,
    WidgetRef ref,
    _OwnerAction action,
  ) async {
    final l10n = AppLocalizations.of(context);
    final api = ref.read(listDetailApiProvider);
    switch (action) {
      case _OwnerAction.visibility:
        try {
          await api.changeVisibility(list.id);
          ref.invalidate(userListsProvider);
          if (context.mounted) {
            showToast(context, l10n.toast_visibilityListSuccess);
          }
        } on Exception {
          if (context.mounted) {
            showToast(context, l10n.toast_visibilityListError);
          }
        }
      case _OwnerAction.delete:
        final confirmed = await showConfirmDialog(
          context,
          message: l10n.listDetail_deleteListConfirm,
          confirmLabel: l10n.common_delete,
        );
        if (!confirmed) return;
        try {
          await api.deleteList(list.id);
          ref.invalidate(userListsProvider);
          if (context.mounted) showToast(context, l10n.toast_deleteListSuccess);
        } on Exception {
          if (context.mounted) showToast(context, l10n.toast_deleteListError);
        }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton<_OwnerAction>(
        key: Key('listCard.${list.id}.menu'),
        padding: EdgeInsets.zero,
        tooltip: l10n.listDetail_manageList,
        icon: SvgPicture.asset(
          'assets/icons/new/vertical_kebab_button.svg',
          width: 18,
          height: 18,
        ),
        onSelected: (action) => _onSelected(context, ref, action),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: _OwnerAction.visibility,
            child: Text(
              list.isPublic
                  ? l10n.listDetail_makePrivate
                  : l10n.listDetail_makePublic,
            ),
          ),
          PopupMenuItem(
            value: _OwnerAction.delete,
            child: Text(
              l10n.listDetail_deleteList,
              style: const TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }
}
