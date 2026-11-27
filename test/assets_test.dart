import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// lib 에서 문자열로 쓰는 asset 경로 (`assets/...`).
Set<String> _referencedAssets() {
  final pattern = RegExp(r"""['"](assets/[^'"$]+\.(?:svg|png|webp|jpg))['"]""");
  return {
    for (final file in Directory('lib').listSync(recursive: true))
      if (file is File && file.path.endsWith('.dart'))
        for (final m in pattern.allMatches(file.readAsStringSync()))
          m.group(1)!,
  };
}

void main() {
  test('lib 가 쓰는 asset 은 모두 있다', () {
    final missing = _referencedAssets().where((p) => !File(p).existsSync());
    expect(missing, isEmpty);
  });

  test(
    '쓰는 SVG 는 flutter_svg 가 그릴 수 있다 (<pattern>/<image> 없음, 채움 없는 root 없음)',
    () {
      final broken = <String>[];
      for (final path in _referencedAssets().where((p) => p.endsWith('.svg'))) {
        final svg = File(path).readAsStringSync();
        final root = RegExp(r'<svg[^>]*>').firstMatch(svg)!.group(0)!;
        // mask/clipPath/defs 안의 도형은 그려지지 않으므로 뺀다.
        final drawn = svg
            .substring(svg.indexOf(root) + root.length)
            .replaceAll(RegExp(r'<(mask|clipPath|defs)[\s\S]*?</\1>'), '');
        // web 은 `<Icon fill={...}>` 로 root 의 fill="none" 을 덮어쓰지만 flutter_svg 는
        // 그대로 상속해 아무것도 그리지 않는다.
        final fillless =
            root.contains('fill="none"') &&
            !RegExp(
              r'<(path|circle|rect|ellipse|polygon|g|line|polyline)[^>]*(fill|stroke)=',
            ).hasMatch(drawn) &&
            !RegExp(r'(fill|stroke)\s*:').hasMatch(drawn);
        if (svg.contains('<pattern') || svg.contains('<image') || fillless) {
          broken.add(path);
        }
      }
      expect(broken, isEmpty);
    },
  );
}
