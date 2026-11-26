# ListyWave App

ListyWave 웹(`ListyWave-front`)의 사용자 기능을 옮기는 Flutter 앱. 계획은 `docs/PLAN.md`.

## 실행

```bash
cp env/dev.example.json env/dev.json   # 값 채우기 (git 에서 제외됨)
flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

prod: `--flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json`

## 검증

```bash
bash scripts/verify.sh
```
