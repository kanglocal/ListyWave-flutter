import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/comment_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/user_profile_image.dart';

/// web `ListDetailOuter/Collaborators.tsx`: 3명까지 프로필을 겹쳐 보이고 나머지는 +N.
/// 누르면 [CollaboratorsDialog] 를 연다.
class Collaborators extends StatelessWidget {
  const Collaborators({super.key, required this.collaborators});

  static const maxVisible = 3;

  final List<CollaboratorType> collaborators;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visible = collaborators.take(maxVisible).toList();
    final rest = collaborators.length - visible.length;
    return Semantics(
      button: true,
      label: l10n.listDetail_collaborator,
      child: GestureDetector(
        key: const Key('listDetail.collaborators'),
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => CollaboratorsDialog(collaborators: collaborators),
        ),
        child: SizedBox(
          height: 32,
          width: 20.0 * (visible.length + (rest > 0 ? 1 : 0)) + 12,
          child: Stack(
            children: [
              for (final (index, c) in visible.indexed)
                Positioned(
                  left: 20.0 * index,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: UserProfileImage(src: c.profileImageUrl, size: 28),
                  ),
                ),
              if (rest > 0)
                Positioned(
                  left: 20.0 * visible.length,
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.skyblue,
                    ),
                    child: Text(
                      '+$rest',
                      style: context.typo.labelSmall.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// web `ListDetailOuter/CollaboratorsModal.tsx`.
class CollaboratorsDialog extends StatelessWidget {
  const CollaboratorsDialog({super.key, required this.collaborators});

  final List<CollaboratorType> collaborators;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      backgroundColor: AppColors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 420),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    l10n.listDetail_collaborator,
                    style: context.typo.bodyBold,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: l10n.common_close,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.gray),
                  ),
                ],
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final c in collaborators)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: UserProfileImage(
                          src: c.profileImageUrl,
                          size: 36,
                        ),
                        title: Text(c.nickname, style: context.typo.body),
                        onTap: () {
                          final router = GoRouter.of(context);
                          Navigator.of(context).pop();
                          router.push(AppRoutes.myList('${c.id}'));
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
