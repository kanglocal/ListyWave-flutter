import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'current_user.dart';
import 'login_sheet.dart';

/// 로그인한 사용자 id. 로그인하지 않았으면 API 를 부르지 않고 로그인 sheet 를 띄운 뒤 null 을
/// 돌려준다 (web 은 같은 자리에서 LoginModal 을 띄운다).
///
/// bottom sheet 안에서도 쓰므로 go_router page 가 아니라 root navigator 의 dialog 로 띄운다
/// (router `authOnEnter` 와 같은 방식). 로그인에 성공하면 sheet 만 닫힌다.
int? requireLogin(BuildContext context) {
  final userId = ProviderScope.containerOf(
    context,
    listen: false,
  ).read(currentUserIdProvider);
  if (userId != null) return userId;
  showDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (_) => const LoginSheet(),
  );
  return null;
}
