import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/upload/image_source.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';
import '../helpers/write_api_mocks.dart';

const _profileUrl =
    'https://bucket.r2.example.com/dev/user_profile/9/k.png?X-Amz-Signature=p';

/// 닉네임 [taken] 은 이미 쓰고, [banned] 는 정책 위반이다.
void _mockProfile(ApiMock api, {String taken = '중복', String banned = '운영자'}) {
  api.adapter
    ..onGet(
      '/users/default-profile-images',
      (s) => s.reply(200, fixture('default_profile_images')),
    )
    ..onGet(
      '/users/default-background-images',
      (s) => s.reply(200, fixture('default_background_images')),
    )
    ..onGet('/users/nickname-validate', (s) => s.reply(200, null))
    ..onGet(
      '/users/nickname-validate',
      (s) => s.reply(400, serverErrorBody()..['status'] = 400),
      queryParameters: {'nickname': banned},
    )
    ..onGet('/users/exists', (s) => s.reply(200, false))
    ..onGet(
      '/users/exists',
      (s) => s.reply(200, true),
      queryParameters: {'nickname': taken},
    )
    ..onPatch('/users/9', (s) => s.reply(204, null), data: Matchers.any)
    ..onPost(
      '/users/upload-url',
      (s) => s.reply(200, {
        'userId': 9,
        'profilePresignedUrl': _profileUrl,
        'backgroundPresignedUrl': '',
      }),
      data: Matchers.any,
    )
    ..onPut(_profileUrl, (s) => s.reply(200, null), data: Matchers.any)
    ..onPost(
      '/users/upload-complete',
      (s) => s.reply(204, null),
      data: Matchers.any,
    );
}

Future<(ProviderContainer, ApiMock)> _open(
  WidgetTester tester, {
  PickImage? pick,
}) async {
  final (container, api) = await pumpWithApi(
    tester,
    userId: 9,
    overrides: [
      ?pick == null ? null : pickImageProvider.overrideWithValue(pick),
    ],
    onMock: _mockProfile,
  );
  final router = container.read(routerProvider);
  router.push(AppRoutes.account);
  await settle(tester);
  router.push(AppRoutes.accountProfile);
  await settle(tester);
  return (container, api);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// 닉네임을 바꾸고 debounce(500ms) 뒤 검사가 끝날 때까지 기다린다.
Future<void> _typeNickname(WidgetTester tester, String nickname) async {
  await tester.enterText(find.byKey(const Key('profile.nickname')), nickname);
  await tester.pump(const Duration(milliseconds: 600));
  await settle(tester);
}

bool _canSave(WidgetTester tester) =>
    tester
        .widget<TextButton>(find.byKey(const Key('profile.save')))
        .onPressed !=
    null;

void main() {
  testWidgets('닉네임을 11자 입력하면 최대 10자 오류가 나오고 저장할 수 없다', (tester) async {
    final (_, api) = await _open(tester);

    await _typeNickname(tester, '가나다라마바사아자차카');

    expect(find.text('닉네임은 최대 10자까지 입력할 수 있어요.'), findsOneWidget);
    expect(_canSave(tester), isFalse);
    // 형식 오류면 서버 검사를 부르지 않는다.
    expect(api.sent('GET', '/users/exists'), isEmpty);
  });

  testWidgets('숫자/특수문자가 들어간 닉네임은 형식 오류다', (tester) async {
    await _open(tester);

    await _typeNickname(tester, 'abc1');

    expect(find.text('한글과 영어만 입력할 수 있어요.'), findsOneWidget);
    expect(_canSave(tester), isFalse);
  });

  testWidgets('이미 쓰는 닉네임이면 중복 오류, 정책 위반이면 사용할 수 없다고 한다', (tester) async {
    final (_, api) = await _open(tester);

    await _typeNickname(tester, '중복');
    expect(find.text('이미 사용중인 닉네임이에요.'), findsOneWidget);
    expect(_canSave(tester), isFalse);

    await _typeNickname(tester, '운영자');
    expect(find.text('사용할 수 없는 닉네임이에요.'), findsOneWidget);
    expect(_canSave(tester), isFalse);
    expect(queriesOf(api, '/users/nickname-validate').last, {
      'nickname': '운영자',
    });
  });

  testWidgets(
    '닉네임 검사 통과 후 저장하면 PATCH /users/{id} {nickname, description, profileImageUrl, backgroundImageUrl}',
    (tester) async {
      final (container, api) = await _open(tester);

      await _typeNickname(tester, '새닉네임');
      expect(find.text('사용 가능한 닉네임이에요.'), findsOneWidget);
      expect(queriesOf(api, '/users/exists').last, {'nickname': '새닉네임'});
      await tester.enterText(
        find.byKey(const Key('profile.description')),
        '새 소개',
      );
      await _tap(
        tester,
        find.byKey(const Key('profile.background.background_2')),
      );
      await _tap(tester, find.byKey(const Key('profile.save')));
      await settle(tester);

      expect(writesOf(api), ['PATCH /users/9']);
      expect(api.sent('PATCH', '/users/9').single.data, {
        'nickname': '새닉네임',
        'description': '새 소개',
        'profileImageUrl': 'https://pub-4f2c1e.r2.dev/users/9/profile.webp',
        'backgroundImageUrl':
            'https://pub-4f2c1e.r2.dev/default/background_2.png',
      });
      expect(find.text('프로필을 수정했습니다.🥰'), findsOneWidget);
      expect(container.read(routerProvider).state.uri.toString(), '/account');
      // 프로필을 다시 읽는다.
      expect(api.sent('GET', '/users/9').length, greaterThanOrEqualTo(2));
    },
  );

  testWidgets(
    '직접 고른 이미지는 PATCH 뒤 upload-url → presigned PUT → upload-complete 로 올린다',
    (tester) async {
      final (_, api) = await _open(
        tester,
        pick: () async => PickedImage(
          bytes: Uint8List(2048),
          mimeType: 'image/png',
          name: 'me.png',
        ),
      );

      await _tap(tester, find.byKey(const Key('profile.profile.upload')));
      await _tap(tester, find.byKey(const Key('profile.save')));
      await settle(tester);

      final put = Uri.parse(_profileUrl).path;
      expect(writesOf(api), [
        'PATCH /users/9',
        'POST /users/upload-url',
        'PUT $put',
        'POST /users/upload-complete',
      ]);
      // 업로드할 이미지는 PATCH 에 넣지 않는다 (업로드 완료가 채운다).
      final patch = api.sent('PATCH', '/users/9').single.data as Map;
      expect(patch.containsKey('profileImageUrl'), isFalse);
      expect(
        patch['backgroundImageUrl'],
        'https://pub-4f2c1e.r2.dev/default/background_1.png',
      );
      expect(api.sent('POST', '/users/upload-url').single.data, {
        'profileExtension': 'png',
      });
      expect(api.sent('POST', '/users/upload-complete').single.data, {
        'profileExtension': 'png',
      });
      final upload = api.sent('PUT', put).single;
      expect(authorizationOf(upload), isNull);
      expect(upload.headers[Headers.contentTypeHeader], 'image/png');
    },
  );
}
