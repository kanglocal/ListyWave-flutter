import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

/// `/search?keyword=&categoryCode=&sort=`.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, this.keyword, this.categoryCode, this.sort});

  final String? keyword;
  final String? categoryCode;
  final String? sort;

  @override
  Widget build(BuildContext context) => PlaceholderScreen(
    title: 'SearchScreen',
    params: {'keyword': keyword, 'categoryCode': categoryCode, 'sort': sort},
  );
}
