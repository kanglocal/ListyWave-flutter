import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Flavor { dev, prod }

/// `--dart-define-from-file=env/<flavor>.json` 으로 주입되는 값 (PLAN §5.4).
class Env {
  const Env({
    required this.flavor,
    required this.apiBaseUrl,
    required this.siteUrl,
    required this.imageBaseUrl,
    required this.kakaoNativeAppKey,
    this.localLoginId = '',
    this.localPassword = '',
  });

  /// 컴파일 타임 define 에서 읽는다. 로컬 로그인 계정은 dev 에서만 쓴다.
  factory Env.fromEnvironment(Flavor flavor) => Env(
    flavor: flavor,
    apiBaseUrl: const String.fromEnvironment('API_BASE_URL'),
    siteUrl: const String.fromEnvironment('SITE_URL'),
    imageBaseUrl: const String.fromEnvironment('IMAGE_BASE_URL'),
    kakaoNativeAppKey: const String.fromEnvironment('KAKAO_NATIVE_APP_KEY'),
    localLoginId: flavor == Flavor.dev
        ? const String.fromEnvironment('LOCAL_LOGIN_ID')
        : '',
    localPassword: flavor == Flavor.dev
        ? const String.fromEnvironment('LOCAL_PASSWORD')
        : '',
  );

  final Flavor flavor;
  final String apiBaseUrl;
  final String siteUrl;
  final String imageBaseUrl;
  final String kakaoNativeAppKey;
  final String localLoginId;
  final String localPassword;

  bool get isDev => flavor == Flavor.dev;
}

/// `bootstrap` 에서 override 한다. override 없이 읽으면 설정 누락이다.
final envProvider = Provider<Env>(
  (ref) => throw StateError('envProvider must be overridden in bootstrap()'),
);
