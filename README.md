# ListyWave App

ListyWave 웹(`ListyWave-front`)의 사용자 기능을 옮기는 Flutter 앱. 계획은 `docs/PLAN.md`.

## 실행

```bash
cp env/dev.example.json env/dev.json   # 값 채우기 (git 에서 제외됨)
flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

prod: `--flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json`

- dev 로그인: 로컬 백엔드(`ListyWave-back`, `!prod` profile)의 `/login/local` 계정을 `env/dev.json` 의
  `LOCAL_LOGIN_ID` / `LOCAL_PASSWORD` 에 넣으면 로그인 sheet 에 "FE 개발용 로그인" 버튼이 생긴다.
- Android 에뮬레이터는 `localhost` 대신 `API_BASE_URL=http://10.0.2.2:8080` 을 쓴다.
  cleartext 는 dev flavor 에서 `localhost`, `10.0.2.2` 만 허용한다.
- iOS: flavor configuration 은 `ios/Podfile` 의 `project 'Runner'` 매핑과
  `ios/Flutter/{Debug,Profile,Release}-{dev,prod}.xcconfig` 의 Pods include 로 연결된다.
  configuration 을 추가하면 두 곳을 같이 고친다.

## 검증

```bash
bash scripts/verify.sh
```

## 출시 빌드와 서명

체크리스트 (무엇이 끝났고 사람이 할 일이 무엇인지) 는 `docs/RELEASE.md`.

버전은 `pubspec.yaml` 의 `version: 1.0.0+1` (이름+빌드 번호) 하나로 정한다. 스토어에 올릴 때마다 `+` 뒤 숫자를 올린다.

```bash
# Android (Play 업로드용 AAB)
flutter build appbundle --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json --release
# iOS (App Store / TestFlight 업로드용 IPA, 서명 필요)
flutter build ipa --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json
```

### Android 서명

`android/app/build.gradle.kts` 는 `android/key.properties` 가 있으면 그 keystore 로 release 를 서명하고,
없으면 debug key 로 서명한다 (CI·다른 개발자 기기에서도 release 빌드가 돌게). debug key 로 서명한 AAB 는
Play 에 올릴 수 없다. `key.properties` 와 `*.jks` / `*.keystore` 는 `android/.gitignore` 로 git 에서 빠진다.

1. upload keystore 를 한 번 만든다 (분실하면 Play Console 에서 upload key 재설정을 요청해야 한다. 비밀번호와 함께 안전한 곳에 백업한다):
   ```bash
   keytool -genkey -v -keystore ~/keys/listywave-upload.jks -keyalg RSA -keysize 2048 \
     -validity 10000 -alias upload
   ```
2. `cp android/key.properties.example android/key.properties` 후 값을 채운다 (`storeFile` 은 절대 경로 또는 `android/app` 기준 상대 경로).
3. Play Console 에서 앱을 만들 때 **Play App Signing** 을 켠다 (Google 이 배포 key 를 보관하고, 우리는 upload key 로 서명한 AAB 를 올린다).
4. 카카오 콘솔 Android 플랫폼에 key hash 3개를 등록한다: debug, upload, Play App Signing (Play Console → 설정 → 앱 서명의 SHA-1).
   ```bash
   keytool -exportcert -alias upload -keystore ~/keys/listywave-upload.jks | openssl sha1 -binary | openssl base64
   keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android | openssl sha1 -binary | openssl base64
   # Play App Signing SHA-1 (콜론 16진수) → key hash
   echo '<SHA-1>' | tr -d ':' | xxd -r -p | openssl base64
   ```
5. 서명 확인: `keytool -printcert -jarfile build/app/outputs/bundle/prodRelease/app-prod-release.aab`

### iOS 서명 / 프로비저닝 (flavor 별)

| flavor | configuration | Bundle ID | 앱 이름 | 아이콘 |
|---|---|---|---|---|
| dev | Debug-dev / Profile-dev / Release-dev | `com.listywave.app.dev` | ListyWave Dev | `AppIcon-dev` (DEV 띠) |
| prod | Debug-prod / Profile-prod / Release-prod | `com.listywave.app` | ListyWave | `AppIcon-prod` |

Runner target 은 `CODE_SIGN_STYLE = Automatic`, `DEVELOPMENT_TEAM = X9PZP88PRD` 이다. 팀이 다르면 Xcode 에서 6개 configuration 모두 바꾼다.

1. Apple Developer → Identifiers 에 두 Bundle ID 를 App ID 로 등록한다. Capability: **Associated Domains** (Universal Links 를 켤 때),
   **Sign in with Apple** (§10-B4 를 채택할 때).
2. App Store Connect 에 prod 앱 (`com.listywave.app`) 을 만든다. dev 를 TestFlight 로 돌리려면 dev 앱도 따로 만든다.
3. 자동 서명: Xcode → Runner → Signing & Capabilities 에서 팀을 고르고 `Release-prod` 를 한 번 빌드하면 Xcode 가 Distribution
   인증서와 App Store 프로비저닝 프로파일을 만든다. 그 뒤 `flutter build ipa --flavor prod ...` 로 IPA 를 만든다.
4. 수동 서명 (CI): Distribution 인증서 (.p12) 와 flavor 별 App Store 프로파일을 받아 키체인/`~/Library/MobileDevice/Provisioning Profiles` 에
   넣고, Release-prod / Release-dev 의 `CODE_SIGN_STYLE = Manual`, `PROVISIONING_PROFILE_SPECIFIER` 를 설정한다.
   또는 `flutter build ipa --export-options-plist=<plist>` 로 프로파일을 지정한다.
5. 업로드: `xcrun altool --upload-app -f build/ios/ipa/*.ipa -t ios --apiKey <KEY_ID> --apiIssuer <ISSUER_ID>` 또는 Transporter 앱.

서명 없이 컴파일만 확인할 때: `flutter build ios --release --no-codesign --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.example.json`

### 아이콘 · 스플래시

원본은 `assets/launcher/` (웹 `public/icons/pwa/ios/ios-pwa-1024.png` 를 잘라 만든 PNG). 설정은
`flutter_launcher_icons-{dev,prod}.yaml`, `flutter_native_splash.yaml`. 원본을 바꾸면 다시 만든다:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
# flutter_native_splash 는 ios/Runner/Info.plist 를 다시 포맷하고 UIStatusBarHidden 을 넣는다. 그 변경은 되돌린다:
git checkout ios/Runner/Info.plist
# flutter_launcher_icons 0.14 는 project.pbxproj 의 ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS 를
# 아이콘 이름으로 덮어쓴다. YES 로 되돌린다.
```

## Deeplink

`listywave://list/1`, 카카오톡 공유의 앱 실행, Universal Links / App Links 설정과 켜는 법,
웹·카카오 콘솔에 요청할 것, 기기 확인 명령은 `docs/deeplinks/README.md`.

## 통합 스모크 테스트

`integration_test/smoke_test.dart`: 로컬 로그인 → 리스트 생성 → 상세 → 댓글 → 콜렉트 → 로그아웃 (PLAN §7 M5).
실제 dev 백엔드와 기기가 필요해 CI 와 `verify.sh` 에서는 돌리지 않는다 (`flutter analyze` 로 컴파일 오류만 잡는다).

1. 로컬 백엔드 (`ListyWave-back`, `!prod` profile) 를 띄우고, 온보딩을 마친 `/login/local` 계정을
   `env/dev.json` 의 `LOCAL_LOGIN_ID` / `LOCAL_PASSWORD` 에 넣는다. 다른 사람의 공개 리스트가 하나 이상 있어야 한다
   (콜렉트는 내 리스트에 할 수 없다).
2. 기기에서 닿는 `API_BASE_URL` 을 쓴다 (iOS 시뮬레이터 `http://localhost:8080`, Android 에뮬레이터 `http://10.0.2.2:8080`).
3. 실행:

```bash
flutter test integration_test/smoke_test.dart --flavor dev \
  --dart-define-from-file=env/dev.json -d <device id>
# 콜렉트할 리스트를 고정하려면 --dart-define=SMOKE_COLLECT_LIST_ID=<id>
```

테스트는 시작할 때 기기의 저장된 세션과 설정 (secure storage, shared_preferences) 을 지운다.

## 테스트 fixture

`test/fixtures/*.json` 은 조회 API 응답이다. PLAN §7 M2 는 dev 서버 응답을 캡처하라고 하지만, M2 작업 시점에
dev 서버가 없어 backend 응답 DTO(`ListyWave-back` 의 `*Response.java`)와 web 타입(`src/lib/types/*.ts`)을
보고 손으로 만들었다. dev 서버를 띄울 수 있게 되면 실제 응답으로 바꾼다 (파일 이름은 그대로 두고,
`test/core/models/model_roundtrip_test.dart` 가 모든 fixture 의 `fromJson → toJson` 왕복을 검사한다).
