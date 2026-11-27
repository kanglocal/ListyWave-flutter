# Deeplink 설정 (PLAN §2.1, §7 M5, §9, §11 Q2–Q4, §12)

앱은 세 가지 링크로 열린다. Flutter 기본 deep linking (`FlutterDeepLinkingEnabled`,
`flutter_deeplinking_enabled`, app_links 패키지 없음) 으로 go_router 에 들어가고, `lib/app/router.dart` 의
`deepLinkLocation` 이 앱 경로로 바꾼다. 예외: iOS 에서는 카카오 SDK plugin 이 `kakao{KEY}://kakaolink` 를
먼저 가로채므로 (`application(_:open:)` 이 true) 이 링크만 `receiveKakaoScheme` 콜백
(`kakaoSchemeReceiverProvider`) 으로 받아 같은 router 로 넘긴다. 앱 경로와 웹 경로는 같다 (`/list/1`, `/user/1/mylist`, `/notice/4` …).

| 링크 | 예 | 앱 경로 | 상태 |
|---|---|---|---|
| custom scheme | `listywave://list/1` | `/list/1` | 켜져 있다 (iOS `CFBundleURLTypes`, Android intent-filter) |
| 카카오톡 공유 → 앱 실행 | `kakao{NATIVE_APP_KEY}://kakaolink?listId=1` | `/list/1` | 앱 쪽은 켜져 있다. 카카오 콘솔 설정이 필요하다 (아래 3) |
| Universal Links / App Links | `https://listywave.vercel.app/list/1` | `/list/1` | iOS 는 꺼 둔다 (§9). Android 는 intent-filter 만 있고 검증은 웹 배포가 필요하다 |

규칙
- 등록되지 않은 경로 (`listywave://unknown`, 웹의 없는 페이지, 모르는 scheme) 는 not-found 화면을 보이고
  "홈으로 가기" 버튼으로 홈에 간다.
- 카카오 링크에 `listId` 가 없거나 숫자가 아니면 홈을 연다.
- 보호 경로 (`/account`, `/collection` …) 링크는 앱 안에서 이동할 때와 같이 비로그인이면 로그인 sheet 를 띄운다.

## 1. 웹 담당에게 요청할 것 (§11 Q3)

웹 저장소 `public/.well-known/` 에 아래 두 파일을 추가한다. 이 앱 저장소의 파일을 그대로 쓰고 placeholder 만 바꾼다.

| 파일 | 바꿀 값 | 값을 얻는 곳 |
|---|---|---|
| [`apple-app-site-association`](apple-app-site-association) (확장자 없음) | `<APPLE_TEAM_ID>` | Apple Developer → Membership 의 Team ID |
| [`assetlinks.json`](assetlinks.json) | `<PLAY_APP_SIGNING_SHA256>` | Play Console → 설정 → 앱 무결성 → 앱 서명 키 인증서 SHA-256 |
|  | `<UPLOAD_KEY_SHA256>` | `keytool -list -v -keystore <upload.jks> -alias <alias>` 의 SHA256 |
|  | `<DEBUG_KEY_SHA256>` | `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android` |

배포 조건
- `https://<SITE_HOST>/.well-known/apple-app-site-association` 과 `/.well-known/assetlinks.json` 이
  **redirect 없이 200** 이고 `Content-Type: application/json` 이어야 한다.
- AASA 는 확장자가 없어 Vercel 이 `application/octet-stream` 으로 줄 수 있다. 웹의 `next.config.js` `headers()` 나
  `vercel.json` `headers` 에 `/.well-known/apple-app-site-association` → `Content-Type: application/json` 을 넣는다.
- `src/middleware.ts` 가 `/.well-known/*` 을 로그인 redirect 하지 않는지 확인한다.
- 확인: `curl -sI https://<SITE_HOST>/.well-known/apple-app-site-association`,
  Apple CDN 반영 확인 `curl -s https://app-site-association.cdn-apple.com/a/v1/<SITE_HOST>`,
  Google 확인 `https://digitalassetlinks.googleapis.com/v1/statements:list?source.web.site=https://<SITE_HOST>&relation=delegate_permission/common.handle_all_urls`.
- 도메인이 바뀌면 (§11 Q2, `DEPLOY.md` "도메인을 사면") 새 도메인에 두 파일을 다시 배포하고 아래 2 의 host 를 바꾼다.

## 2. 앱에서 켜는 법

### iOS Universal Links (기본 꺼짐)

도메인이 확정되고 1 의 AASA 가 배포된 뒤에 켠다.

1. Apple Developer 의 App ID (`com.listywave.app`, `com.listywave.app.dev`) 에 **Associated Domains** capability 를 켜고
   provisioning profile 을 다시 만든다.
2. `ios/Flutter/UniversalLinks.xcconfig` 의 한 줄을 바꾼다.
   ```
   UNIVERSAL_LINKS_ENABLED=YES
   ```
   그러면 `CODE_SIGN_ENTITLEMENTS=Runner/Runner.entitlements` 가 되어
   `com.apple.developer.associated-domains = applinks:$(UNIVERSAL_LINK_HOST)` 로 서명된다.
3. host 는 flavor 별 `ios/Flutter/{Debug,Profile,Release}-{dev,prod}.xcconfig` 의 `UNIVERSAL_LINK_HOST` 다
   (지금 dev/prod 모두 `listywave.vercel.app`). 도메인이 바뀌면 이 값도 바꾼다.

꺼져 있으면 entitlement 가 서명에 들어가지 않으므로 Associated Domains capability 없는 profile 로도 빌드된다.

### Android App Links

- `android/app/src/main/AndroidManifest.xml` 의 `autoVerify="true"` intent-filter 가 `http(s)://${appLinkHost}/list/…`,
  `/user/…`, `/notice/…` 를 받는다.
- `appLinkHost` 는 `android/app/build.gradle.kts` 가 `--dart-define-from-file=env/<flavor>.json` 의 `SITE_URL` host 로 채운다.
  prod 는 `listywave.vercel.app`, dev 는 `env/dev.json` 의 `SITE_URL` (기본 `localhost`) 이다.
  dev 앱으로 웹 링크를 시험하려면 dev env 의 `SITE_URL` 을 웹 도메인으로 바꿔 빌드한다.
- 웹에 `assetlinks.json` 이 없으면 검증이 실패하고 Android 12+ 는 링크를 브라우저로 연다. 앱 동작은 그대로다.

## 3. 카카오 콘솔에 요청할 것 (§11 Q4)

메시지 템플릿 `103935` 의 버튼 (웹 링크는 그대로 둔다) 에 앱 실행 파라미터를 추가한다.

- Android 실행 파라미터: `listId=${listId}`
- iOS 실행 파라미터: `listId=${listId}`

`${listId}` 는 앱과 웹이 보내는 template 인자 (`kakaoListTemplateArgs` 의 `listId`, 웹 `kakaotalkShare.ts`) 다.
카카오톡은 앱이 설치되어 있으면 `kakao{NATIVE_APP_KEY}://kakaolink?listId=123` 로 앱을 연다.
플랫폼 등록 (Android 패키지명·key hash, iOS 번들 ID) 은 §12 체크리스트를 따른다.

앱 쪽 scheme 등록
- iOS: `ios/scripts/kakao_url_scheme.sh` (Runner build phase) 가 빌드된 `Info.plist` 의 `CFBundleURLTypes` 에
  `kakao{KEY}` 를 **덧붙인다** (`listywave` 는 남긴다). 키가 비어 있으면 아무것도 하지 않는다.
- Android: `kakaoScheme` manifest placeholder (`build.gradle.kts`).

## 4. 기기에서 확인하는 명령

앱 (dev flavor) 을 먼저 설치한다.

```bash
# iOS 시뮬레이터
xcrun simctl openurl booted "listywave://list/1"
xcrun simctl openurl booted "listywave://user/1/mylist"
xcrun simctl openurl booted "kakao<NATIVE_APP_KEY>://kakaolink?listId=1"
xcrun simctl openurl booted "listywave://unknown"                      # not-found 화면
# Universal Link: 1 의 AASA 배포 + 2 의 UNIVERSAL_LINKS_ENABLED=YES + 서명된 빌드가 필요하다
xcrun simctl openurl booted "https://listywave.vercel.app/list/1"

# Android (dev 패키지는 com.listywave.app.dev)
adb shell am start -a android.intent.action.VIEW -d "listywave://list/1"
adb shell am start -a android.intent.action.VIEW -d "listywave://user/1/mylist"
adb shell am start -a android.intent.action.VIEW -d "kakao<NATIVE_APP_KEY>://kakaolink?listId=1"
# App Link: 웹에 assetlinks.json 이 배포되어 있어야 검증된다. SITE_URL 이 웹 도메인인 빌드에서
adb shell am start -a android.intent.action.VIEW -d "https://listywave.vercel.app/list/1"
adb shell pm verify-app-links --re-verify com.listywave.app
adb shell pm get-app-links com.listywave.app                           # verified 인지 확인
# assetlinks 배포 전 수동 확인용: 사용자 선택으로 host 를 앱에 묶는다
adb shell pm set-app-links-user-selection --user cur --package com.listywave.app true listywave.vercel.app
```

빌드 산출물 확인
- iOS: `/usr/libexec/PlistBuddy -c "Print :CFBundleURLTypes" build/ios/iphoneos/Runner.app/Info.plist`
- Android: `build/app/intermediates/merged_manifests/devDebug/processDevDebugManifest/AndroidManifest.xml`
  (또는 `aapt dump xmltree <apk> AndroidManifest.xml`)
