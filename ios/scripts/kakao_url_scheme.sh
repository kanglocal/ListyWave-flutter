#!/bin/sh
# 카카오톡 공유 메시지에서 앱으로 돌아오는 URL scheme `kakao{NATIVE_APP_KEY}` 를 빌드된 Info.plist 에
# 넣는다 (PLAN §12). 키는 `--dart-define-from-file=env/<flavor>.json` 의 KAKAO_NATIVE_APP_KEY 로,
# Flutter 가 Generated.xcconfig 의 DART_DEFINES (base64, 쉼표 구분) 로 넘긴다.
# 키가 비어 있으면 (로컬 dev) 아무것도 하지 않는다.
set -eu

key=""
old_ifs="$IFS"
IFS=','
for encoded in ${DART_DEFINES:-}; do
  decoded="$(printf '%s' "$encoded" | base64 --decode 2>/dev/null || true)"
  case "$decoded" in
    KAKAO_NATIVE_APP_KEY=*) key="${decoded#KAKAO_NATIVE_APP_KEY=}" ;;
  esac
done
IFS="$old_ifs"

[ -n "$key" ] || exit 0

plist="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
buddy=/usr/libexec/PlistBuddy
"$buddy" -c "Delete :CFBundleURLTypes" "$plist" >/dev/null 2>&1 || true
"$buddy" -c "Add :CFBundleURLTypes array" "$plist"
"$buddy" -c "Add :CFBundleURLTypes:0 dict" "$plist"
"$buddy" -c "Add :CFBundleURLTypes:0:CFBundleURLName string kakao" "$plist"
"$buddy" -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes array" "$plist"
"$buddy" -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes:0 string kakao${key}" "$plist"
