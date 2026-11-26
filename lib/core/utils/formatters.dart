import '../l10n/gen/app_localizations.dart';

/// backend `LocalDateTime` 문자열 (시간대 없음, 한국 시간). 기기 시간대로 읽는다 (web 과 같다).
DateTime? _parse(String value) => DateTime.tryParse(value);

String _two(int n) => n.toString().padLeft(2, '0');

/// web `lib/utils/dateFormat.ts`: `YYYY-MM-DD`.
String formatDate(String value) {
  final date = _parse(value);
  if (date == null) return value;
  return '${date.year}-${_two(date.month)}-${_two(date.day)}';
}

/// web `lib/utils/dateTimeFormat.ts`: `YYYY.MM.DD HH:mm`.
String formatDateTime(String value) {
  final date = _parse(value);
  if (date == null) return value;
  return '${date.year}.${_two(date.month)}.${_two(date.day)} '
      '${_two(date.hour)}:${_two(date.minute)}';
}

/// web `lib/utils/time-diff.ts`. [now] 는 테스트용이다.
String timeDiff(String value, AppLocalizations l10n, {DateTime? now}) {
  final date = _parse(value);
  if (date == null) return value;
  final diff = (now ?? DateTime.now()).difference(date).inSeconds;
  if (diff < 60) return l10n.time_justNow;
  if (diff < 60 * 60) return l10n.time_minutesAgo(diff ~/ 60);
  if (diff < 60 * 60 * 24) return l10n.time_hoursAgo(diff ~/ (60 * 60));
  if (diff < 60 * 60 * 24 * 7) return l10n.time_daysAgo(diff ~/ (60 * 60 * 24));
  final monthDay = '${_two(date.month)}-${_two(date.day)}';
  if (diff < 60 * 60 * 24 * 365) return monthDay;
  return '${date.year}-$monthDay';
}

/// web `lib/utils/numberFormatter.ts`. web 화면은 항상 'ko' 로 부른다.
String formatCount(int num, {String lang = 'ko'}) {
  const unit = 10000;
  if (num < unit) {
    final digits = num.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
  if (lang == 'ko') {
    final value = (num / unit * 10).truncate() / 10;
    return '${_trim(value)}만';
  }
  final thousands = (num / unit * 10).truncate();
  if (thousands < 1000) return '${thousands}K';
  return '${_trim((thousands / 1000 * 10).truncate() / 10)}M';
}

String _trim(double value) =>
    value == value.truncateToDouble() ? '${value.toInt()}' : '$value';
