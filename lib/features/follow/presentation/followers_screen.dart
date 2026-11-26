import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) =>
      PlaceholderScreen(title: 'FollowersScreen', params: {'userId': userId});
}
