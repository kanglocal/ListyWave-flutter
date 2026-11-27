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
