import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class ListEditScreen extends StatelessWidget {
  const ListEditScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context) =>
      PlaceholderScreen(title: 'ListEditScreen', params: {'listId': listId});
}
