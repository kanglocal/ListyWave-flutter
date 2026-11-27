import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:listywave_app/features/list_detail/presentation/widgets/save_image_dialog.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ko');
    await initializeDateFormatting('en');
  });

  group('저장 이미지 (web SaveImageModal)', () {
    test('사이트 주소는 web new URL(DOMAIN_URL).host 처럼 host(와 포트)만 쓴다', () {
      expect(
        siteHostOf('https://listywave.vercel.app'),
        'listywave.vercel.app',
      );
      expect(
        siteHostOf('https://listywave.vercel.app/'),
        'listywave.vercel.app',
      );
      expect(siteHostOf('http://localhost:3000'), 'localhost:3000');
    });

    test('수정 시각은 web toLocaleString 모양으로 쓴다', () {
      expect(
        formatUpdatedDate('2026-11-27T15:37:30.876597', const Locale('ko')),
        '2026. 11. 27. 오후 3:37:30',
      );
      expect(
        formatUpdatedDate('2026-11-27T09:05:07', const Locale('en')),
        '11/27/2026 9:05:07\u202fAM', // intl 은 AM 앞에 좁은 공백(U+202F)을 쓴다,
      );
      expect(formatUpdatedDate('not-a-date', const Locale('ko')), 'not-a-date');
    });
  });
}
