import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/token_storage.dart';
import 'package:listywave_app/core/network/app_exception.dart';
import 'package:listywave_app/core/network/dio_provider.dart';

import '../../helpers/test_container.dart';

const _expired = {
  'status': 401,
  'error': 'UNAUTHORIZED',
  'code': 'INVALID_ACCESS_TOKEN',
  'detail': '유효하지 않은 액세스 토큰입니다.',
  'message': '만료된 액세스 토큰입니다.',
};

void main() {
  test('401 이 동시에 3개 와도 /auth/token 은 1회만 부르고 3개 모두 새 AT 로 재시도한다', () async {
    final secure = {'accessToken': 'at-old', 'refreshToken': 'rt'};
    final container = createTestContainer(secure: secure);
    addTearDown(container.dispose);
    final api = ApiMock(container);
    var refreshCalls = 0;
    for (final path in ['/alarms', '/folders', '/users/1']) {
      api.adapter
        ..onGet(
          path,
          (s) => s.reply(401, _expired),
          headers: {'Authorization': 'Bearer at-old'},
        )
        ..onGet(
          path,
          (s) => s.reply(200, {'path': path}),
          headers: {'Authorization': 'Bearer at-new'},
        );
    }
    api.adapter.onGet(
      '/auth/token',
      (s) => s.replyCallback(200, (_) {
        refreshCalls++;
        return {'accessToken': 'at-new'};
      }, delay: const Duration(milliseconds: 50)),
      headers: {'Authorization': 'Bearer rt'},
    );

    final dio = container.read(dioProvider);
    final responses = await Future.wait([
      dio.get<Map<String, dynamic>>('/alarms'),
      dio.get<Map<String, dynamic>>('/folders'),
      dio.get<Map<String, dynamic>>('/users/1'),
    ]);

    expect(refreshCalls, 1);
    expect(api.sent('GET', '/auth/token'), hasLength(1));
    expect(responses.map((r) => r.data!['path']), [
      '/alarms',
      '/folders',
      '/users/1',
    ]);
    for (final path in ['/alarms', '/folders', '/users/1']) {
      final sent = api.sent('GET', path);
      expect(sent.map(authorizationOf), ['Bearer at-old', 'Bearer at-new']);
    }
    expect(secure['accessToken'], 'at-new');
  });

  test('body 없는 401 (MalformedJwtException) 도 refresh 한다', () async {
    final container = createTestContainer(
      secure: {'accessToken': 'at-bad', 'refreshToken': 'rt'},
    );
    addTearDown(container.dispose);
    final api = ApiMock(container);
    api.adapter
      ..onPost(
        '/lists',
        // GlobalExceptionHandler.handleMalformedJwtException: body 도 content-type 도 없다.
        (s) => s.reply(401, '', headers: const {}),
        data: {'title': 't'},
        headers: {'Authorization': 'Bearer at-bad'},
      )
      ..onPost(
        '/lists',
        (s) => s.reply(201, {'id': 7}),
        data: {'title': 't'},
        headers: {'Authorization': 'Bearer at-new'},
      )
      ..onGet(
        '/auth/token',
        (s) => s.reply(200, {'accessToken': 'at-new'}),
        headers: {'Authorization': 'Bearer rt'},
      );

    final response = await container
        .read(dioProvider)
        .post<Object?>('/lists', data: {'title': 't'});

    expect(response.statusCode, 201);
    expect(api.sent('GET', '/auth/token'), hasLength(1));
    expect(api.sent('POST', '/lists').map(authorizationOf), [
      'Bearer at-bad',
      'Bearer at-new',
    ]);
  });

  test('refresh 가 실패하면 storage 가 비고 AuthState 가 loggedOut 이 된다', () async {
    final secure = {'accessToken': 'at-old', 'refreshToken': 'rt-expired'};
    final container = createTestContainer(secure: secure, prefs: {'userId': 1});
    addTearDown(container.dispose);
    final api = ApiMock(container);
    api.adapter
      // 공개 GET fallback (Authorization 없음). 아래 401 mock 보다 먼저 등록해야
      // Authorization 이 있는 요청은 401 mock 에 걸린다 (마지막으로 맞은 mock 이 이긴다).
      ..onGet('/users/1', (s) => s.reply(200, {'id': 1}))
      ..onGet(
        '/users/1',
        (s) => s.reply(401, _expired),
        headers: {'Authorization': 'Bearer at-old'},
      )
      ..onGet(
        '/auth/token',
        (s) => s.reply(401, _expired),
        headers: {'Authorization': 'Bearer rt-expired'},
      );

    // 앱 시작 세션 확인 (GET /users/{userId}) 이 401 → refresh 실패로 이어진다.
    final sub = container.listen(authControllerProvider, (_, _) {});
    addTearDown(sub.close);
    expect(sub.read(), const AuthState.unknown());
    await _until(() => sub.read().status != AuthStatus.unknown);
    // 공개 GET fallback 이 끝날 때까지 기다려도 loggedIn 으로 덮어쓰지 않는다.
    await _until(() => api.sent('GET', '/users/1').length == 2);
    await pumpEventQueue();

    expect(sub.read(), const AuthState.loggedOut(reason: LogoutReason.expired));
    expect(secure, isEmpty);
    expect(await container.read(tokenStorageProvider).readUserId(), isNull);
    expect(api.sent('GET', '/auth/token'), hasLength(1));
    expect(api.sent('GET', '/users/1').map(authorizationOf), [
      'Bearer at-old',
      null,
    ]);
    // 만료 로그아웃은 서버 로그아웃(PATCH /auth/kakao)을 부르지 않는다.
    expect(api.sent('PATCH', '/auth/kakao'), isEmpty);
  });

  test('쓸 수 있는 RT 가 없으면 공개 GET 401 을 Authorization 없이 한 번 재시도한다', () async {
    final secure = {'accessToken': 'at-expired'};
    final container = createTestContainer(secure: secure);
    addTearDown(container.dispose);
    final api = ApiMock(container);
    api.adapter
      ..onGet('/lists/recommend', (s) => s.reply(200, <Object>[]))
      ..onGet(
        '/lists/recommend',
        (s) => s.reply(401, _expired),
        headers: {'Authorization': 'Bearer at-expired'},
      );

    final response = await container
        .read(dioProvider)
        .get<List<dynamic>>('/lists/recommend');

    expect(response.statusCode, 200);
    expect(api.sent('GET', '/lists/recommend').map(authorizationOf), [
      'Bearer at-expired',
      null,
    ]);
    expect(api.sent('GET', '/auth/token'), isEmpty);
    expect(secure, isEmpty);
  });

  test('공개 GET fallback 도 401 이면 더 재시도하지 않고 AppException 을 준다', () async {
    final container = createTestContainer(secure: {'accessToken': 'at-x'});
    addTearDown(container.dispose);
    final api = ApiMock(container);
    api.adapter.onGet(
      '/folders',
      (s) => s.reply(401, {
        'status': 401,
        'error': 'UNAUTHORIZED',
        'code': 'REQUIRED_ACCESS_TOKEN',
        'detail': '접근 토큰이 필요합니다.',
        'message': '접근 토큰이 필요합니다.',
      }),
    );

    final error = await container
        .read(dioProvider)
        .get<Object?>('/folders')
        .then<Object?>((_) => null, onError: (Object e) => e);

    expect(api.sent('GET', '/folders'), hasLength(2));
    expect(error, isA<DioException>());
    final app = AppException.from(error!);
    expect((app.status, app.code), (401, 'REQUIRED_ACCESS_TOKEN'));
  });

  test('ErrorMapper 는 body 없는 오류도 AppException 으로 바꾼다', () async {
    final container = createTestContainer();
    addTearDown(container.dispose);
    final api = ApiMock(container);
    api.adapter.onGet('/topics', (s) => s.reply(500, 'boom'));

    final error = await container
        .read(dioProvider)
        .get<Object?>('/topics')
        .then<Object?>((_) => null, onError: (Object e) => e);

    final app = (error! as DioException).error! as AppException;
    expect((app.status, app.code, app.message), (500, 'HTTP_500', 'boom'));
  });
}

Future<void> _until(bool Function() condition) async {
  for (var i = 0; i < 200 && !condition(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
  expect(condition(), isTrue, reason: 'timed out');
}
