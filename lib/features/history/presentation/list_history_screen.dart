import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class ListHistoryScreen extends StatelessWidget {
  const ListHistoryScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context) =>
      PlaceholderScreen(title: 'ListHistoryScreen', params: {'listId': listId});
}
