import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

/// `/list/create?title=&category=` (web 프리필 query 그대로).
class ListCreateScreen extends StatelessWidget {
  const ListCreateScreen({super.key, this.title, this.category});

  final String? title;
  final String? category;

  @override
  Widget build(BuildContext context) => PlaceholderScreen(
    title: 'ListCreateScreen',
    params: {'title': title, 'category': category},
  );
}
