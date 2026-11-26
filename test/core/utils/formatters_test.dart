import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/l10n/gen/app_localizations_ko.dart';
import 'package:listywave_app/core/utils/formatters.dart';

void main() {
  final l10n = AppLocalizationsKo();
  final now = DateTime(2024, 11, 21, 12);

  test('timeDiff 는 web time-diff.ts 와 같은 구간으로 나눈다', () {
    String diff(DateTime d) => timeDiff(d.toIso8601String(), l10n, now: now);

    expect(diff(now.subtract(const Duration(seconds: 30))), '방금 전');
    expect(diff(now.subtract(const Duration(minutes: 5))), '5분 전');
    expect(diff(now.subtract(const Duration(hours: 3))), '3시간 전');
    expect(diff(now.subtract(const Duration(days: 2))), '2일 전');
    expect(diff(DateTime(2024, 10, 2, 8)), '10-02');
    expect(diff(DateTime(2023, 1, 5)), '2023-01-05');
  });

  test('formatDate / formatDateTime 은 backend LocalDateTime 문자열을 그대로 읽는다', () {
    expect(formatDate('2024-11-20T14:31:08.123456'), '2024-11-20');
    expect(formatDateTime('2024-11-20T14:31:08.123456'), '2024.11.20 14:31');
    expect(formatDate('not a date'), 'not a date');
  });

  test('formatCount 는 web numberFormatter.ts 와 같다', () {
    expect(formatCount(0), '0');
    expect(formatCount(9999), '9,999');
    expect(formatCount(10500), '1만');
    expect(formatCount(355000), '35.5만');
    expect(formatCount(355300, lang: 'en'), '355K');
    expect(formatCount(5100000, lang: 'en'), '5.1M');
  });
}
