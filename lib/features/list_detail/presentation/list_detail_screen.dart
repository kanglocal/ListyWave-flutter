import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class ListDetailScreen extends StatelessWidget {
  const ListDetailScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context) =>
      PlaceholderScreen(title: 'ListDetailScreen', params: {'listId': listId});
}
