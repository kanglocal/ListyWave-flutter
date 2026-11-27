# 출시 체크리스트 (PLAN §7 M6, §12)

> 결론: 코드로 할 수 있는 출시 준비 (아이콘·스플래시, 글꼴 라이선스, Android 서명 분기, 버전, 서명 없는 prod 빌드) 는 끝났다.
> 남은 일은 모두 **계정·콘솔·키가 있는 사람**이 해야 한다. iOS 는 Sign in with Apple (§10-B4) 이 정해지기 전까지 심사 반려 위험이 크다.

표시: ✅ 끝남 (저장소에 반영됨) · 👤 사람이 할 일 (무엇을 어떻게) · ⚠️ 출시 차단 위험

빌드·서명 명령은 `README.md` "출시 빌드와 서명".

## 1. 빌드

- ✅ 버전 `pubspec.yaml` `version: 1.0.0+1`. Android `versionName/versionCode`, iOS `CFBundleShortVersionString/CFBundleVersion` 이 여기서 나온다.
- ✅ `flutter build appbundle --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.example.json --release` 성공 (key.properties 가 없어 debug key 서명).
- ✅ `flutter build ios --release --no-codesign --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.example.json` 성공.
- 👤 `env/prod.json` 을 만든다 (`env/prod.example.json` 복사): `API_BASE_URL` (운영 `https://<IP>.sslip.io`), `SITE_URL`, `IMAGE_BASE_URL` (R2 공개 URL), `KAKAO_NATIVE_APP_KEY`. `LOCAL_LOGIN_ID`/`LOCAL_PASSWORD` 는 비워 둔다 (운영 백엔드에는 `/login/local` 이 없다).
- 👤 업로드용 빌드는 `env/prod.json` 으로 다시 만든다 (example 값으로 만든 빌드는 서버에 붙지 않는다).

## 2. Bundle ID / applicationId

- ✅ 기본값 `com.listywave.app`, dev 는 `.dev` suffix (Android `applicationIdSuffix`, iOS `FLAVOR_BUNDLE_SUFFIX`).
- 👤 조직 소유 도메인으로 바꿀지 확정한다 (Q2). 바꾸면 `android/app/build.gradle.kts` 의 `applicationId`/`namespace`, `ios/Runner.xcodeproj` 의 `PRODUCT_BUNDLE_IDENTIFIER`, 카카오 콘솔 플랫폼, AASA/assetlinks 를 함께 바꾼다. **스토어에 한 번 올리면 바꿀 수 없다.**

## 3. 서명

- ✅ Android: `android/key.properties` 가 있으면 release 를 그 keystore 로 서명, 없으면 debug key 로 서명 (`android/app/build.gradle.kts`). `key.properties`, `*.jks`, `*.keystore` 는 git 제외. 예시 `android/key.properties.example`.
- 👤 Android upload keystore 를 만들고 `android/key.properties` 를 채운다 (README 1~2단계). keystore 와 비밀번호를 팀 비밀 저장소에 백업한다.
- 👤 Play Console 에서 앱 생성 시 Play App Signing 을 켠다.
- 👤 iOS: Apple Developer 에 `com.listywave.app`, `com.listywave.app.dev` App ID 등록, App Store Connect 앱 생성, Distribution 인증서·App Store 프로파일 (자동 서명이면 Xcode 가 만든다). 팀 ID 는 지금 `X9PZP88PRD` 로 들어가 있다. 다른 팀이면 6개 configuration 을 모두 바꾼다.
- 👤 `flutter build ipa --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json` 로 서명된 IPA 를 만든다 (이 환경에서는 `--no-codesign` 빌드만 확인했다).

## 4. 아이콘 / 스플래시 / 스크린샷

- ✅ 앱 아이콘: 웹 `public/icons/pwa/ios/ios-pwa-1024.png` 의 둥근 사각형 안쪽을 잘라 투명 모서리를 그라데이션으로 채웠다 (`assets/launcher/icon.png`, iOS 는 alpha 금지). dev 는 빨간 "DEV" 띠 (`icon_dev.png`). Android `src/{dev,prod}/res/mipmap-*`, iOS `AppIcon-{dev,prod}.appiconset` (configuration 별 `ASSETCATALOG_COMPILER_APPICON_NAME`).
- ✅ 스플래시: 흰 배경 + 웹 PWA 아이콘 (`flutter_native_splash.yaml`, Android 12+ 용 여백 큰 이미지 따로). dev/prod 공용.
- 👤 Android adaptive icon (전경/배경 분리) 은 만들지 않았다. Android 8+ 런처는 지금 아이콘을 축소해 흰 원/사각 위에 올린다. 디자이너가 전경 (파도+서핑보드, 투명 배경) 을 주면 `flutter_launcher_icons-*.yaml` 에 `adaptive_icon_foreground/background` 를 넣는다.
- 👤 스토어 스크린샷: iPhone 6.9"(1320x2868) / 6.5", iPad 13" (iPad 지원을 끄지 않는 한 필수), Play 폰 2~8장. 시뮬레이터에서 `xcrun simctl io booted screenshot` 으로 찍는다.
- 👤 스토어 메타데이터: 앱 이름, 부제, 설명, 키워드, 카테고리 (소셜 네트워킹 또는 라이프스타일), 지원 URL, 연령 등급 설문 (사용자 생성 콘텐츠 → 신고/차단 기능 요구, 아래 §9).

## 5. 라이선스

- ✅ Pretendard SIL OFL 1.1 원문 `assets/licenses/Pretendard-OFL.txt` 를 `bootstrap()` 에서 `LicenseRegistry` 에 등록 (`registerFontLicenses`, 테스트 `test/core/font_license_test.dart`).
- 👤 앱에는 아직 `showLicensePage` 로 가는 메뉴가 없다 (웹에도 없다). 설정 화면에 "오픈소스 라이선스" 를 둘지 정한다. 두면 패키지 라이선스와 Pretendard 가 함께 나온다.

## 6. 카카오 개발자 콘솔 (웹과 같은 앱)

- ✅ 코드: iOS `LSApplicationQueriesSchemes` (`kakaokompassauth`, `kakaolink`, `kakaotalk`), `kakao{KEY}` URL scheme 은 빌드 때 `ios/scripts/kakao_url_scheme.sh` 가 넣는다. Android manifest 의 `kakao{KEY}://kakaolink` intent-filter 는 `env/*.json` 의 키로 채운다.
- 👤 플랫폼 Android: 패키지명 `com.listywave.app` (+ dev 를 쓸 거면 `com.listywave.app.dev`), key hash 3종 (debug / upload / Play App Signing). 명령은 README "Android 서명" 4단계.
- 👤 플랫폼 iOS: 번들 ID `com.listywave.app` (+ `.dev`).
- 👤 앱 키 → 네이티브 앱 키를 `env/prod.json` 의 `KAKAO_NATIVE_APP_KEY` 에 넣는다.
- 👤 메시지 템플릿 103935 에 앱 실행 파라미터 (Android/iOS 실행 링크) 추가 (Q4). 없으면 공유 링크가 웹으로 열린다.
- ✅ 로그인 Redirect URI: 앱은 웹 URI (`https://listywave.vercel.app/auth/redirect/kakao`) 를 그대로 쓴다. 추가 등록 없음.
- 👤 운영 백엔드 `.env` 의 `OAUTH_KAKAO_REDIRECTURI` 가 운영 웹 URL 인지 확인 (`deploy/.env.example:23`).

## 7. URL scheme / 링크

- ✅ `listywave://` scheme, Android App Links intent-filter (`autoVerify`, host = `SITE_URL` host), iOS Associated Domains entitlement (스위치 `ios/Flutter/UniversalLinks.xcconfig`, 지금 `NO`).
- 👤 도메인 확정 후 웹에 `/.well-known/apple-app-site-association`, `/.well-known/assetlinks.json` 배포 (Play App Signing SHA-256 포함) → `UNIVERSAL_LINKS_ENABLED=YES` → App ID 에 Associated Domains capability. 절차는 `docs/deeplinks/README.md`.

## 8. API / 권한

- ✅ API 는 HTTPS (sslip.io + Let's Encrypt) 라 ATS·cleartext 예외 없음. cleartext 는 dev flavor 의 `localhost`/`10.0.2.2` 만 (`android/app/src/dev/res/xml/network_security_config.xml`).
- ✅ iOS 권한 문구: `NSPhotoLibraryUsageDescription` (사진 선택), `NSPhotoLibraryAddUsageDescription` (리스트 이미지 저장). 카메라는 쓰지 않는다 (`ImageSource.gallery` 만) → `NSCameraUsageDescription` 불필요.
- ✅ Android: `image_picker` 가 Android 13+ 에서 Photo Picker 를 써 미디어 권한이 필요 없다. `WRITE_EXTERNAL_STORAGE` 는 `maxSdkVersion` 이 있는 이미지 저장용 (Android 10 이하, `maxSdkVersion=29`).
- 👤 iOS 개인정보 매니페스트: 앱 코드가 직접 쓰는 required-reason API 는 없다 (UserDefaults 등은 plugin 이 자체 `PrivacyInfo.xcprivacy` 를 갖는다). 업로드 후 App Store Connect 가 경고하면 `ios/Runner/PrivacyInfo.xcprivacy` 를 추가한다.

## 9. 개인정보처리방침 · 계정 삭제 · 콘텐츠 정책

- ✅ 개인정보처리방침 URL (웹 인트로 Footer 와 같음, 앱 인트로 Footer 에 링크): `https://cypress-tv-724.notion.site/2118cc63884e4365b753cac553f3f7ed?pvs=4`
- 👤 위 Notion 문서가 앱도 다루는지 확인하고 고친다: 수집 항목 (카카오 이메일 `account_email`, 카카오 회원 번호, 닉네임·프로필/배경 이미지·소개, 리스트·아이템·댓글·이미지), 보관 기간, 탈퇴 시 삭제, 처리 위탁 (서버 호스팅, Cloudflare R2 이미지 저장), 문의처 `listywave8@gmail.com`. 두 스토어 모두 같은 URL 을 넣는다. 도메인이 생기면 웹 페이지로 옮기는 것을 권장한다 (Notion 공개 링크는 바뀔 수 있다).
- ✅ 계정 삭제: 앱 안 계정 화면 → 회원 탈퇴 (`DELETE /withdraw`, `lib/features/account/presentation/withdraw_screen.dart`). Apple 5.1.1(v) 충족.
- 👤 Play Console 데이터 보안 → "계정 삭제 URL": `https://listywave.vercel.app/account/withdraw` (웹 탈퇴 화면. 로그인이 필요하다는 점과 삭제되는 데이터를 개인정보처리방침에 적는다). 도메인이 바뀌면 URL 도 바꾼다.
- 👤 사용자 생성 콘텐츠 (Apple 1.2, Play UGC 정책): 신고·차단 수단과 문의처가 필요하다. 앱에는 댓글 삭제 (본인) 만 있고 **신고/차단 기능이 없다** → 심사 질문을 받으면 운영 문의 메일로 처리한다고 답하거나, 신고 기능을 서버와 함께 추가한다 (서버 작업 필요).

## 10. App Privacy (App Store) / Data safety (Play) 답변 초안

앱이 실제로 보내는 데이터 기준 (`lib/core/network`, `lib/features/*/data`). 분석·광고·크래시 SDK 는 없다 (Q6). 위치, 연락처, 결제, 건강, 기기 ID 수집 없음. 추적 (tracking) 없음.

**App Store — App Privacy** ("Data Linked to You", 목적은 모두 App Functionality, Tracking 아님)

| 유형 | 항목 | 근거 |
|---|---|---|
| Contact Info | Email Address | 카카오 로그인 `account_email` (서버가 카카오에서 받는다) |
| Identifiers | User ID | 서버 회원 id, 카카오 회원 번호 |
| User Content | Photos or Videos | 리스트 아이템·프로필·배경 이미지 업로드 (R2) |
| User Content | Other User Content | 리스트·아이템 제목/설명, 댓글·답글, 닉네임·소개, 주제 요청 |

수집 안 함: Name (닉네임은 사용자가 정하는 공개 프로필이라 Other User Content 로 넣었다), Usage Data, Diagnostics, Location, Contacts, Browsing History, Purchases.

**Google Play — Data safety**

| 데이터 유형 | 수집 | 공유 | 필수/선택 | 목적 |
|---|---|---|---|---|
| 개인 정보 → 이메일 주소 | 예 | 아니요 | 필수 (로그인) | 앱 기능, 계정 관리 |
| 개인 정보 → 사용자 ID | 예 | 아니요 | 필수 | 앱 기능, 계정 관리 |
| 사진 및 동영상 → 사진 | 예 | 아니요 | 선택 | 앱 기능 |
| 앱 활동 → 기타 사용자 생성 콘텐츠 | 예 | 아니요 | 선택 | 앱 기능 |

- 전송 중 암호화: 예 (HTTPS).
- 삭제 요청: 예 (앱 안 탈퇴 + 위 웹 URL).
- 서버 호스팅·R2 는 "처리 위탁 (service provider)" 이라 "공유" 에 넣지 않는다.
- 비로그인 사용자는 데이터를 보내지 않는다 (조회만).

## 11. Sign in with Apple ⚠️ (§10-B4, Q11)

- 상황: 로그인 수단이 카카오 하나다. App Store Review Guideline 4.8 은 제3자 로그인으로 계정을 만드는 앱에 "이름·이메일만 받고, 이메일을 숨길 수 있고, 광고 추적에 쓰지 않는" 대체 로그인 (Sign in with Apple 이 충족) 을 요구한다. 지금 상태로 iOS 를 제출하면 **4.8 반려 가능성이 높다**.
- 👤 서버 담당과 B4 채택 여부를 정한다: `POST /auth/apple {identityToken}` (Apple 공개키로 검증, `LoginResponse` 재사용), 회원 테이블에 provider 구분이 필요할 수 있다 (`findByOauthId`).
- 채택하면 앱 작업: `sign_in_with_apple` 패키지, 로그인 sheet 버튼, Runner 의 Sign in with Apple capability (entitlement), App ID capability. 탈퇴 시 Apple REST API (`https://appleid.apple.com/auth/revoke`) 로 token 을 폐기하는 일도 서버가 해야 한다 (5.1.1(v)).
- 채택이 늦어지면: PLAN Q11 대로 Android 를 먼저 출시하고 iOS 는 보류한다.

## 12. 배포

- 👤 Play: 내부 테스트 트랙에 AAB 업로드 → 테스터 이메일 등록 → 검토 통과 후 프로덕션. 새 개인 개발자 계정이면 프로덕션 전 비공개 테스트 (12명 이상, 14일) 요구가 있다.
- 👤 iOS: IPA 업로드 → TestFlight 내부 테스터 → 심사 제출. 심사 메모에 테스트 계정이 필요하다 (카카오 로그인 → 심사용 카카오 계정을 만들어 ID/PW 를 적는다).
- 👤 업로드 후 PLAN §7 M6 수용 기준의 "내부 테스트 트랙 업로드 완료" 를 체크한다.
