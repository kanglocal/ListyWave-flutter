import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// web `user/[userId]/_components/Card.tsx`. 주인이면 공개 여부, 아니면 카테고리를 보인다.
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
