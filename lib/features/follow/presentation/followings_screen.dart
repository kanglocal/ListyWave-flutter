import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class FollowingsScreen extends StatelessWidget {
  const FollowingsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) =>
      PlaceholderScreen(title: 'FollowingsScreen', params: {'userId': userId});
}
