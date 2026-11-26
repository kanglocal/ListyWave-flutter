import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/router.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/user_profile_type.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/no_data.dart';
import '../../../../core/widgets/user_profile_image.dart';

/// web `user/[userId]/(follow)/_components/UserList.tsx` + followers/followings page.
/// 팔로워 삭제 버튼은 M3 에서 붙인다.
class FollowUserListScaffold extends StatelessWidget {
  const FollowUserListScaffold({
    super.key,
    required this.title,
    required this.userId,
    required this.users,
    required this.emptyMessage,
    required this.onRetry,
  });

  final String title;
  final String userId;
  final FollowUsersValue users;
  final String emptyMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final Widget body = switch (users) {
      (users: final list?, error: _) when list.isEmpty => ListView(
        children: [NoDataView(message: emptyMessage)],
      ),
      (users: final list?, error: _) => ListView.builder(
        key: const Key('follow.list'),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: list.length,
        itemBuilder: (context, index) => FollowUserTile(user: list[index]),
      ),
      (users: null, error: final error?) => ListView(
        children: [ErrorView(error: error, onRetry: onRetry)],
      ),
      _ => Skeletonizer(
        child: ListView(
          children: [
            for (var i = 0; i < 6; i++)
              FollowUserTile(
                user: UserProfileType(
                  id: i,
                  profileImageUrl: null,
                  nickname: 'nickname',
                ),
              ),
          ],
        ),
      ),
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title, style: context.typo.bodyBold),
        // web 은 뒤로가기를 누르면 그 사용자의 마이리스트로 간다.
        leading: BackButton(
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.myList(userId)),
        ),
      ),
      body: body,
    );
  }
}

/// 화면이 그릴 값: 목록(받았으면) 과 오류(실패했으면).
typedef FollowUsersValue = ({List<UserProfileType>? users, Object? error});

class FollowUserTile extends StatelessWidget {
  const FollowUserTile({super.key, required this.user});

  final UserProfileType user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: UserProfileImage(
        src: user.profileImageUrl,
        size: 40,
        semanticLabel: l10n.user_profileImageAlt,
      ),
      title: Text(user.nickname, style: context.typo.bodyBold),
      onTap: () => context.push(AppRoutes.myList('${user.id}')),
    );
  }
}
