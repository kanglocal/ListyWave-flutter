import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class CollectionFolderScreen extends StatelessWidget {
  const CollectionFolderScreen({super.key, required this.folderId});

  final String folderId;

  @override
  Widget build(BuildContext context) => PlaceholderScreen(
    title: 'CollectionFolderScreen',
    params: {'folderId': folderId},
  );
}
