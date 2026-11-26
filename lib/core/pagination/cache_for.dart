import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tanstack `staleTime` 대응 (PLAN §5.2). autoDispose provider 를 마지막 listener 가
/// 사라진 뒤에도 [duration] 동안 살려 둔다.
extension CacheForRef on Ref {
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    onDispose(timer.cancel);
  }
}
