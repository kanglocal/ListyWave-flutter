import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/app.dart';
import 'package:listywave_app/app/env.dart';

const testEnv = Env(
  flavor: Flavor.dev,
  apiBaseUrl: 'http://localhost:8080',
  siteUrl: 'http://localhost:3000',
  imageBaseUrl: 'http://localhost:9000/listywave-local',
  kakaoNativeAppKey: '',
);

/// 실제 앱 위젯 트리를 띄우고, 그 router 에 접근할 수 있는 container 를 돌려준다.
Future<ProviderContainer> pumpApp(WidgetTester tester) async {
  final container = ProviderContainer(
    overrides: [envProvider.overrideWithValue(testEnv)],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const ListyWaveApp(),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}
