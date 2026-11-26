#!/usr/bin/env bash
# 마일스톤 공통 완료 조건 (PLAN §7, §8.3). exit 0 이어야 "완료" 다.
set -euo pipefail
cd "$(dirname "$0")/.."

step() { printf '\n==> %s\n' "$*"; }
fail() { printf '\nverify: FAIL: %s\n' "$*" >&2; exit 1; }

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "git 저장소가 아니다 (생성물 커밋 검사에 git 이 필요하다)"

step "flutter pub get"
flutter pub get

step "flutter gen-l10n (ko/en 키 불일치 금지)"
rm -f build/untranslated.txt
flutter gen-l10n
# gen-l10n 은 누락이 없어도 "{}" 를 쓴다. 공백을 뺀 내용이 비었거나 "{}" 여야 통과다.
untranslated="$(tr -d '[:space:]' < build/untranslated.txt 2>/dev/null || true)"
if [ -n "$untranslated" ] && [ "$untranslated" != "{}" ]; then
  cat build/untranslated.txt >&2
  fail "번역되지 않은 ARB 키가 있다 (build/untranslated.txt)"
fi

step "dart format"
dart format --output=none --set-exit-if-changed lib test

step "build_runner"
dart run build_runner build

step "생성물(*.g.dart, *.freezed.dart) 커밋 누락/변경 검사"
# untracked 파일도 잡기 위해 diff 대신 status 를 쓴다. -uall 은 새 폴더 안의 파일까지 펼친다.
generated="$(git status --porcelain --untracked-files=all -- '*.g.dart' '*.freezed.dart')"
if [ -n "$generated" ]; then
  printf '%s\n' "$generated" >&2
  fail "build_runner 생성물이 커밋되지 않았거나 최신이 아니다"
fi

step "flutter analyze"
flutter analyze --fatal-infos

step "flutter test"
flutter test --coverage

step "가짜 완료 방지 (skip/only, 미구현 placeholder)"
if grep -rnE "skip: *true|\.only\(|UnimplementedError\(|TODO\(port\)" lib test; then
  fail "skip/only 또는 미구현 placeholder 가 남아 있다"
fi

printf '\nverify: OK\n'
