import 'package:flutter/material.dart';

/// web `toasting({type, txt})` 대신 쓰는 SnackBar (PLAN §6 react-toastify).
///
/// SnackBar 는 web toast 와 달리 쌓이지 않고 하나만 보인다. 그래서 이용 정지 안내
/// ([showSuspendedNotice]) 가 떠 있는 [suspendedNoticeHold] 동안에는 화면별 실패 안내
/// ('댓글 처리에 실패했어요' 등) 로 덮지 않는다. 같은 요청이 실패한 이유가 정지 안내다.
void showToast(BuildContext context, String message) {
  final shownAt = _suspendedNoticeShownAt;
  if (shownAt != null &&
      _toastClock().difference(shownAt) < suspendedNoticeHold) {
    return;
  }
  ScaffoldMessenger.maybeOf(context)
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// 이용 정지 안내를 다른 안내가 덮지 못하는 시간. web 의 중복 안내 방지 3초와 같다.
const suspendedNoticeHold = Duration(seconds: 3);

DateTime? _suspendedNoticeShownAt;
DateTime Function() _toastClock = DateTime.now;

/// 이용 정지 안내를 띄운다 (앱 루트 listener 가 부른다).
void showSuspendedNotice(ScaffoldMessengerState messenger, String message) {
  _suspendedNoticeShownAt = _toastClock();
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// 테스트용: 시계를 바꾸고, 정지 안내 기록을 지운다.
@visibleForTesting
void debugResetToast({DateTime Function()? clock}) {
  _toastClock = clock ?? DateTime.now;
  _suspendedNoticeShownAt = null;
}
