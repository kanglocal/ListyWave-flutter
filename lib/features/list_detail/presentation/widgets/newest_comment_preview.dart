import 'package:flutter/material.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/user_profile_image.dart';

/// web `ListDetailOuter/NewestCommentPreview.tsx`.
class NewestCommentPreview extends StatelessWidget {
  const NewestCommentPreview({super.key, required this.comment});

  final NewestCommentType? comment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = comment;
    if (c == null) {
      return Text(
        l10n.comment_empty,
        style: context.typo.label.copyWith(color: AppColors.gray),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileImage(src: c.userProfileImageUrl, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(c.userNickname, style: context.typo.labelBold),
                  const SizedBox(width: 6),
                  Text(
                    timeDiff(c.createdDate, l10n),
                    style: context.typo.labelSmall.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(c.content, style: context.typo.label),
              const SizedBox(height: 4),
              Text(
                c.totalReplyCount > 0
                    ? l10n.comment_replyCount(c.totalReplyCount)
                    : l10n.comment_reply,
                style: context.typo.labelSmall.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
