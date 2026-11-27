import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/l10n/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('저장한 적이 없으면 ko 다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(localeControllerProvider.notifier).loaded;

    expect(container.read(localeControllerProvider), AppLanguage.ko);
  });

  test('en 으로 바꾸면 저장되고, 새 container 도 저장소에서 en 을 읽는다', () async {
    final first = ProviderContainer();
    await first.read(localeControllerProvider.notifier).select(AppLanguage.en);
    expect(first.read(localeControllerProvider), AppLanguage.en);
    first.dispose();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(LocaleController.storageKey), 'en');

    final restarted = ProviderContainer();
    addTearDown(restarted.dispose);
    final notifier = restarted.read(localeControllerProvider.notifier);
    await notifier.loaded;
    expect(restarted.read(localeControllerProvider), AppLanguage.en);
  });

  test('bootstrap 이 미리 읽은 언어로 시작한다', () {
    final container = ProviderContainer(
      overrides: [initialLanguageProvider.overrideWithValue(AppLanguage.en)],
    );
    addTearDown(container.dispose);

    expect(container.read(localeControllerProvider), AppLanguage.en);
  });
}
