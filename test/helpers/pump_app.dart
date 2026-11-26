import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/app.dart';

import 'test_container.dart';

export 'test_container.dart' show ApiMock, authorizationOf, testEnv;

/// 실제 앱 위젯 트리를 띄우고, 그 router 에 접근할 수 있는 container 를 돌려준다.
/// [beforePump] 는 첫 frame 전에 불린다 (API mock 연결 등).
Future<ProviderContainer> pumpApp(
  WidgetTester tester, {
  Map<String, String>? secure,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
  void Function(ProviderContainer container)? beforePump,
}) async {
  final container = createTestContainer(
    secure: secure,
    prefs: prefs,
    overrides: overrides,
  );
  addTearDown(container.dispose);
  beforePump?.call(container);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const ListyWaveApp(),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

/// 저장된 세션(userId [userId])이 `GET /users/{userId}` 로 확인된 로그인 상태로 앱을 띄운다.
Future<ProviderContainer> pumpLoggedInApp(
  WidgetTester tester, {
  int userId = 9,
}) => pumpApp(
  tester,
  secure: {'accessToken': 'at', 'refreshToken': 'rt'},
  prefs: {'userId': userId},
  beforePump: (c) => ApiMock(
    c,
  ).adapter.onGet('/users/$userId', (s) => s.reply(200, {'id': userId})),
);
