import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/l10n/gen/app_localizations.dart';
import 'package:listywave_app/core/l10n/gen/app_localizations_ko.dart';
import 'package:listywave_app/core/validation/validators.dart';

void main() {
  final AppLocalizations l10n = AppLocalizationsKo();

  group('닉네임 (web nicknameRules, backend Nickname)', () {
    test('11자면 최대 10자 오류다', () {
      expect(validateNickname(l10n, '가나다라마바사아자차카'), '닉네임은 최대 10자까지 입력할 수 있어요.');
      expect(validateNickname(l10n, '가나다라마바사아자차'), isNull);
    });

    test('비었으면 필수 오류, 한글/영어 외 문자는 형식 오류다', () {
      expect(validateNickname(l10n, ''), '닉네임을 입력해 주세요.');
      for (final bad in ['abc1', '리 스티', 'ㄱㄴ', 'hi!', ' 앞공백']) {
        expect(validateNickname(l10n, bad), '한글과 영어만 입력할 수 있어요.', reason: bad);
      }
      expect(validateNickname(l10n, 'Listy리스티'), isNull);
    });
  });

  test('리스트 제목 30자, 소개 200자, 아이템 100자, 코멘트 100자 (backend 기준)', () {
    expect(validateListTitle(l10n, 'a' * 30), isNull);
    expect(validateListTitle(l10n, 'a' * 31), '리스트 타이틀은 최대 30자까지 입력할 수 있어요.');
    expect(validateListTitle(l10n, '  '), '타이틀을 입력해 주세요');
    expect(validateListDescription(l10n, 'a' * 200), isNull);
    expect(validateListDescription(l10n, 'a' * 201), isNotNull);
    expect(validateItemTitle(l10n, 'a' * 100), isNull);
    expect(validateItemTitle(l10n, 'a' * 101), isNotNull);
    expect(validateItemTitle(l10n, ''), '아이템을 입력해 주세요.');
    expect(validateItemComment(l10n, 'a' * 100), isNull);
    expect(validateItemComment(l10n, 'a' * 101), '코멘트는 최대 100자까지 입력할 수 있어요.');
  });

  test('라벨: 한글/영어/숫자 10자, 최대 3개, 대소문자 무시 중복 금지', () {
    expect(validateNewLabel(l10n, '성수', const []), isNull);
    expect(validateNewLabel(l10n, 'a' * 11, const []), isNotNull);
    expect(validateNewLabel(l10n, '특수!', const []), '유효한 한글, 영어, 숫자만 입력해 주세요.');
    expect(
      validateNewLabel(l10n, 'd', const ['a', 'b', 'c']),
      '태그는 3개까지 등록할 수 있어요.',
    );
    expect(validateNewLabel(l10n, 'ABC', const ['abc']), '이미 등록한 태그예요.');
  });

  test('링크는 web 패턴을 따르고 http 가 없으면 붙인다', () {
    expect(validateLink(l10n, 'listywave.com'), isNull);
    expect(validateLink(l10n, 'https://www.youtube.com/watch?v=1'), isNull);
    expect(validateLink(l10n, 'not a url'), '올바른 URL 형식이 아니에요.');
    expect(validateLink(l10n, ''), '링크를 입력해 주세요');
    expect(ensureHttp('listywave.com'), 'http://listywave.com');
    expect(ensureHttp('https://a.com'), 'https://a.com');
  });

  test('폴더 이름은 비울 수 없고 30자까지다', () {
    expect(validateFolderName(l10n, ' '), '폴더명을 작성해 주세요.');
    expect(validateFolderName(l10n, 'a' * 30), isNull);
    expect(validateFolderName(l10n, 'a' * 31), isNotNull);
  });
}
