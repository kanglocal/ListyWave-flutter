import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/widgets/toast.dart';

/// 모든 테스트 파일에 적용된다. 이용 정지 안내 기록은 전역이라, 앞 테스트에서 띄운 안내가
/// 다음 테스트의 toast 를 막지 않도록 테스트마다 지운다.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUp(debugResetToast);
  await testMain();
}
