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
    // web `NewestCommentPreview.css.ts`.
    final ink = context.typo.label.copyWith(color: AppColors.black3);
    if (c == null) {
      return Text(
        l10n.comment_empty,
        style: ink.copyWith(fontSize: 13, color: AppColors.gray3),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileImage(src: c.userProfileImageUrl, size: 30),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      c.userNickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ink.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    timeDiff(c.createdDate, l10n),
                    style: ink.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.36,
                      color: AppColors.gray3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                c.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ink.copyWith(
                  fontSize: 13,
                  height: 17 / 13,
                  letterSpacing: -0.39,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                c.totalReplyCount > 0
                    ? l10n.comment_replyCount(c.totalReplyCount)
                    : l10n.comment_reply,
                style: ink.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
