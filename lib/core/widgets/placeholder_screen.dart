import 'package:flutter/material.dart';

import '../theme/typography.dart';

/// M0 라우터 골격용 화면. 각 마일스톤에서 실제 화면으로 바꾼다.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, this.params});

  final String title;

  /// path/query 파라미터. 라우팅이 값을 제대로 넘기는지 눈으로 확인하는 용도다.
  final Map<String, String?>? params;

  @override
  Widget build(BuildContext context) {
    final entries = params?.entries ?? const <MapEntry<String, String?>>[];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: context.typo.header),
            for (final e in entries)
              Text('${e.key}: ${e.value ?? '-'}', style: context.typo.body),
          ],
        ),
      ),
    );
  }
}
