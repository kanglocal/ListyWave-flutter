import 'package:go_router/go_router.dart';

/// 백엔드 `LoginResponse.java` 모양의 응답.
Map<String, Object?> loginJson({int id = 1, bool isFirst = false}) => {
  'id': id,
  'profileImageUrl': null,
  'backgroundImageUrl': null,
  'nickname': 'tester',
  'description': null,
  'followingCount': 0,
  'followerCount': 0,
  'isFirst': isFirst,
  'accessToken': 'at-$id',
  'refreshToken': 'rt-$id',
};

String locationOf(GoRouter router) =>
    router.routerDelegate.currentConfiguration.uri.toString();
