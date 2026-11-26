import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/pagination/cache_for.dart';

void main() {
  testWidgets('cacheFor 는 listener 가 없어도 기간 동안 살려 두고, 지나면 dispose 한다', (
    tester,
  ) async {
    var builds = 0;
    var disposed = 0;
    final provider = Provider.autoDispose<int>((ref) {
      ref.cacheFor(const Duration(minutes: 5));
      ref.onDispose(() => disposed++);
      return ++builds;
    });
    final container = ProviderContainer();

    container.listen(provider, (_, _) {}).close();
    await tester.pump(const Duration(minutes: 4));
    expect(disposed, 0);
    expect(container.read(provider), 1);

    await tester.pump(const Duration(minutes: 2));
    expect(disposed, 1);
    expect(container.read(provider), 2);

    // 다시 만든 provider 의 timer 는 container 와 함께 정리된다.
    container.dispose();
    expect(disposed, 2);
  });
}
