import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인한 사용자 id. M0 에는 인증이 없으므로 항상 null 이다.
/// M1 에서 `AuthController` 상태에서 읽도록 바꾼다.
final currentUserIdProvider = Provider<int?>((ref) => null);
