import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

import 'app/app.dart';
import 'app/env.dart';
import 'core/l10n/locale_controller.dart';
import 'core/network/retry_policy.dart';

Future<void> bootstrap(Env env) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 카카오톡 공유 SDK (PLAN §6, §12). 키가 없으면 (로컬 dev) 초기화하지 않고, 공유 sheet 는
  // 카카오톡 항목을 눌렀을 때 사용할 수 없다고 안내한다.
  if (env.kakaoNativeAppKey.isNotEmpty) {
    await KakaoSdk.init(nativeAppKey: env.kakaoNativeAppKey);
  }
  // 저장된 언어로 첫 frame 을 그린다 (ko 로 그렸다가 en 으로 바뀌지 않게).
  final language = await LocaleController.readStoredLanguage();
  runApp(
    ProviderScope(
      retry: appRetry,
      overrides: [
        envProvider.overrideWithValue(env),
        initialLanguageProvider.overrideWithValue(language),
      ],
      child: const ListyWaveApp(),
    ),
  );
}
