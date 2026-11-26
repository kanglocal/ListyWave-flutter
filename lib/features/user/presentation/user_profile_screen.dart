import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

/// web `/user/[userId]/mylist` 와 `/collabolist` 는 같은 화면의 탭이다.
enum UserProfileTab { my, collabo }

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userId, required this.tab});

  final String userId;
  final UserProfileTab tab;

  @override
  Widget build(BuildContext context) => PlaceholderScreen(
    title: 'UserProfileScreen',
    params: {'userId': userId, 'tab': tab.name},
  );
}
