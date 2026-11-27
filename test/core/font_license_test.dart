import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/bootstrap.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bootstrap 이 Pretendard SIL OFL 원문을 LicenseRegistry 에 등록한다', () async {
    registerFontLicenses();

    final entries = await LicenseRegistry.licenses
        .where((entry) => entry.packages.contains('Pretendard'))
        .toList();

    expect(entries, hasLength(1));
    final text = entries.single.paragraphs.map((p) => p.text).join('\n');
    expect(text, contains("Reserved Font Name 'Pretendard'"));
    expect(text, contains('SIL OPEN FONT LICENSE Version 1.1'));
  });
}
