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
