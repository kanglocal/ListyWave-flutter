import 'package:flutter/widgets.dart';
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
  final disposer = _ContainerDisposer(container);
  addTearDown(disposer.dispose);
  beforePump?.call(container);
  await tester.pumpWidget(
    _DisposeOnUnmount(
      disposer: disposer,
      child: UncontrolledProviderScope(
        container: container,
        child: const ListyWaveApp(),
      ),
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

/// 화면이 안정될 때까지 기다린다. go_router 의 부모 route (예: `/notice/9` 의 `/notice`) 는
/// 전환 애니메이션이 끝나는 마지막 frame 에 offstage 로 처음 build 되어, 그때 시작한 요청의
/// 0초 Timer 가 [WidgetTester.pumpAndSettle] 뒤에도 남는다. 시간을 한 번 더 흘려 마저 끝낸다.
Future<void> settle(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(Duration.zero);
  await tester.pumpAndSettle();
}

/// container 를 한 번만 dispose 한다.
class _ContainerDisposer {
  _ContainerDisposer(this._container);

  final ProviderContainer _container;
  bool _disposed = false;

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _container.dispose();
  }
}

/// 위젯 트리가 내려갈 때 container 를 dispose 한다. flutter_test 는 트리를 내린 직후
/// (addTearDown 보다 먼저) 남은 Timer 를 검사하는데, `cacheFor` 의 keepAlive Timer 와
/// Riverpod 재시도 Timer 는 container 가 dispose 되어야 취소되기 때문이다.
class _DisposeOnUnmount extends StatefulWidget {
  const _DisposeOnUnmount({required this.disposer, required this.child});

  final _ContainerDisposer disposer;
  final Widget child;

  @override
  State<_DisposeOnUnmount> createState() => _DisposeOnUnmountState();
}

class _DisposeOnUnmountState extends State<_DisposeOnUnmount> {
  @override
  void dispose() {
    widget.disposer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
