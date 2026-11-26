import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/current_user.dart';
import 'package:listywave_app/core/auth/token_storage.dart';

import '../../helpers/test_container.dart';

void main() {
  late Map<String, String> secure;
  late int cookieClears;
  late ProviderContainer container;
  late ApiMock api;

  ProviderContainer create({Map<String, Object> prefs = const {}}) {
    container = createTestContainer(
      secure: secure,
      prefs: prefs,
      clearCookies: () async => cookieClears++,
    );
    addTearDown(container.dispose);
    api = ApiMock(container);
    return container;
  }

  Future<AuthState> settled() async {
    final sub = container.listen(authControllerProvider, (_, _) {});
    addTearDown(sub.close);
    for (var i = 0; i < 100 && sub.read().status == AuthStatus.unknown; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }
    return sub.read();
  }

  setUp(() {
    secure = {};
    cookieClears = 0;
  });

  test('저장된 세션이 없으면 요청 없이 loggedOut 이다', () async {
    create();

    expect(await settled(), const AuthState.loggedOut());
    expect(api.requests, isEmpty);
    expect(container.read(currentUserIdProvider), isNull);
  });

  test('저장된 세션은 GET /users/{userId} 로 확인하고 loggedIn 이 된다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create(prefs: {'userId': 4});
    api.adapter.onGet(
      '/users/4',
      (s) => s.reply(200, {'id': 4}),
      headers: {'Authorization': 'Bearer at'},
    );

    expect(await settled(), const AuthState.loggedIn(4));
    expect(api.sent('GET', '/users/4'), hasLength(1));
    expect(container.read(currentUserIdProvider), 4);
  });

  test('userId 없이 토큰만 남아 있으면 (재설치) 토큰을 지운다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create();

    expect(await settled(), const AuthState.loggedOut());
    expect(secure, isEmpty);
  });

  test('오프라인이면 저장된 세션을 그대로 쓴다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create(prefs: {'userId': 4});
    // mock 이 없는 요청은 응답 없는 오류가 된다.

    expect(await settled(), const AuthState.loggedIn(4));
    expect(secure, isNotEmpty);
  });

  test('logout(user) 는 PATCH /auth/kakao 를 부르고, 실패해도 토큰과 쿠키를 지운다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create(prefs: {'userId': 4});
    api.adapter
      ..onGet('/users/4', (s) => s.reply(200, {'id': 4}))
      ..onPatch('/auth/kakao', (s) => s.reply(500, 'down'));
    await settled();

    await container
        .read(authControllerProvider.notifier)
        .logout(LogoutReason.user);

    final patch = api.sent('PATCH', '/auth/kakao');
    expect(patch, hasLength(1));
    expect(authorizationOf(patch.single), 'Bearer at');
    expect(
      container.read(authControllerProvider),
      const AuthState.loggedOut(reason: LogoutReason.user),
    );
    expect(container.read(currentUserIdProvider), isNull);
    expect(secure, isEmpty);
    expect(await container.read(tokenStorageProvider).readUserId(), isNull);
    expect(cookieClears, 1);
  });

  test('withdraw 는 DELETE /withdraw 후 로그아웃한다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create(prefs: {'userId': 4});
    api.adapter
      ..onGet('/users/4', (s) => s.reply(200, {'id': 4}))
      ..onDelete('/withdraw', (s) => s.reply(204, null));
    await settled();

    await container.read(authControllerProvider.notifier).withdraw();

    expect(api.sent('DELETE', '/withdraw'), hasLength(1));
    expect(api.sent('PATCH', '/auth/kakao'), isEmpty);
    expect(
      container.read(authControllerProvider),
      const AuthState.loggedOut(reason: LogoutReason.withdraw),
    );
    expect(secure, isEmpty);
    expect(cookieClears, 1);
  });

  test('DELETE /withdraw 가 실패하면 로그인 상태를 유지한다', () async {
    secure.addAll({'accessToken': 'at', 'refreshToken': 'rt'});
    create(prefs: {'userId': 4});
    api.adapter
      ..onGet('/users/4', (s) => s.reply(200, {'id': 4}))
      ..onDelete('/withdraw', (s) => s.reply(500, 'boom'));
    await settled();

    await expectLater(
      container.read(authControllerProvider.notifier).withdraw(),
      throwsA(anything),
    );

    expect(container.read(authControllerProvider), const AuthState.loggedIn(4));
    expect(secure, isNotEmpty);
  });
}
