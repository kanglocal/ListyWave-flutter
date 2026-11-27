import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/core/network/app_exception.dart';
import 'package:listywave_app/core/network/dio_provider.dart';
import 'package:listywave_app/core/network/suspended_user_interceptor.dart';

import '../../helpers/test_container.dart';

Map<String, Object> _body(int status, String code) => {
  'status': status,
  'error': 'FORBIDDEN',
  'code': code,
  'detail': code,
  'message': code,
};

void main() {
  test('403 SUSPENDED_USER 는 3초 안에 여러 번 와도 한 번만 알리고, 3초가 지나면 다시 알린다', () async {
    var now = DateTime(2026, 11, 27, 12);
    var notified = 0;
    final dio = Dio(BaseOptions(baseUrl: testEnv.apiBaseUrl));
    dio.interceptors.add(
      SuspendedUserInterceptor(() => notified++, clock: () => now),
    );
    DioAdapter(dio: dio)
      ..onPost('/comments', (s) => s.reply(403, _body(403, 'SUSPENDED_USER')))
      ..onPost('/other', (s) => s.reply(403, _body(403, 'FORBIDDEN_ACCESS')));

    Future<void> post(String path) =>
        expectLater(dio.post<void>(path), throwsA(isA<DioException>()));

    await post('/comments');
    await post('/comments');
    expect(notified, 1);

    now = now.add(const Duration(seconds: 3));
    await post('/comments');
    expect(notified, 1);

    now = now.add(const Duration(milliseconds: 1));
    await post('/comments');
    expect(notified, 2);

    // 다른 403 은 알리지 않는다.
    now = now.add(const Duration(seconds: 10));
    await post('/other');
    expect(notified, 2);
  });

  test(
    '앱 Dio 는 403 SUSPENDED_USER 를 suspendedUserNoticeProvider 로 알리고 오류는 그대로 넘긴다',
    () async {
      final container = createTestContainer();
      addTearDown(container.dispose);
      final api = ApiMock(container);
      api.adapter.onPost(
        '/lists/7/comments',
        (s) => s.reply(403, _body(403, 'SUSPENDED_USER')),
        data: {'content': 'x'},
      );

      await expectLater(
        container
            .read(dioProvider)
            .post<void>('/lists/7/comments', data: {'content': 'x'}),
        throwsA(
          isA<DioException>().having(
            (e) => AppException.from(e).code,
            'code',
            'SUSPENDED_USER',
          ),
        ),
      );
      expect(container.read(suspendedUserNoticeProvider), 1);
    },
  );
}
