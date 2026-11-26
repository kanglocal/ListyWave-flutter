import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';

/// 로그인한 사용자 id. 로그인하지 않았거나 세션 확인 전이면 null 이다.
/// 인증에 따라 결과가 달라지는 provider 는 이것을 watch 해서 로그인/로그아웃 때 다시 만들어진다.
final currentUserIdProvider = Provider<int?>(
  (ref) => ref.watch(authControllerProvider.select((s) => s.userId)),
);
