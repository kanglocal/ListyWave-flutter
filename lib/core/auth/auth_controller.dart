import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/env.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_provider.dart';
import 'kakao_login_webview.dart';
import 'login_response.dart';
import 'token_storage.dart';

enum AuthStatus { unknown, loggedIn, loggedOut }

/// 로그아웃 이유. [expired] 면 앱이 "다시 로그인해주세요" 를 띄운다.
enum LogoutReason { user, expired, withdraw }

@immutable
class AuthState {
  const AuthState._(this.status, {this.userId, this.reason});

  /// 앱 시작 직후 세션 확인 전.
  const AuthState.unknown() : this._(AuthStatus.unknown);
  const AuthState.loggedIn(int userId)
    : this._(AuthStatus.loggedIn, userId: userId);
  const AuthState.loggedOut({LogoutReason? reason})
    : this._(AuthStatus.loggedOut, reason: reason);

  final AuthStatus status;
  final int? userId;

  /// 로그아웃 상태가 된 이유. 앱 시작 때 세션이 없었으면 null 이다.
  final LogoutReason? reason;

  bool get isLoggedIn => status == AuthStatus.loggedIn;

  @override
  bool operator ==(Object other) =>
      other is AuthState &&
      other.status == status &&
      other.userId == userId &&
      other.reason == reason;

  @override
  int get hashCode => Object.hash(status, userId, reason);

  @override
  String toString() => 'AuthState($status, userId: $userId, reason: $reason)';
}

/// 로그인 상태 (PLAN §4.3). 만들어지면 저장된 세션을 확인한다.
class AuthController extends Notifier<AuthState> {
  TokenStorage get _storage => ref.read(tokenStorageProvider);
  Dio get _dio => ref.read(dioProvider);

  @override
  AuthState build() {
    Future.microtask(_restore);
    return const AuthState.unknown();
  }

  /// 저장된 토큰이 있으면 `GET /users/{userId}` 로 세션을 확인한다.
  /// AT 가 만료되었으면 interceptor 가 갱신하고, 갱신도 실패하면 [logout] 이 불린다.
  Future<void> _restore() async {
    final userId = await _storage.readUserId();
    final accessToken = await _storage.readAccessToken();
    if (userId == null || accessToken == null) {
      // 재설치 뒤 Keychain 에만 토큰이 남은 경우도 여기서 지운다.
      await _storage.clear();
      if (_isUnknown) state = const AuthState.loggedOut();
      return;
    }
    try {
      await _dio.get<Object?>('/users/$userId');
    } on DioException catch (e) {
      // 오프라인이거나 서버 오류(5xx)면 저장된 세션을 그대로 쓴다.
      final status = e.response?.statusCode;
      if (status != null && status >= 400 && status < 500 && _isUnknown) {
        await logout(LogoutReason.expired);
        return;
      }
    }
    // 갱신 실패로 이미 로그아웃되었으면 공개 GET fallback 이 성공했더라도 덮어쓰지 않는다.
    if (_isUnknown) state = AuthState.loggedIn(userId);
  }

  bool get _isUnknown => state.status == AuthStatus.unknown;

  Future<void> login(LoginResponse response) async {
    await _storage.save(
      userId: response.id,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    state = AuthState.loggedIn(response.id);
  }

  /// WebView 가 넘긴 인가 code 를 토큰으로 바꾸고 로그인한다 (PLAN §4.2).
  /// 탈퇴 회원이면 400 `AppException` 이 난다.
  Future<LoginResponse> loginWithKakaoCode(String code) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/auth/redirect/kakao',
      queryParameters: {'code': code},
    );
    final login = LoginResponse.fromJson(response.data!);
    await this.login(login);
    return login;
  }

  /// dev 서버 전용 로그인 (`DevAuthController`, `@Profile("!prod")`).
  Future<LoginResponse> loginLocal() async {
    final env = ref.read(envProvider);
    final response = await _dio.post<Map<String, dynamic>>(
      '/login/local',
      data: {'account': env.localLoginId, 'password': env.localPassword},
    );
    final login = LoginResponse.fromJson(response.data!);
    await this.login(login);
    return login;
  }

  /// 로컬 토큰과 WebView 쿠키를 지운다.
  /// 사용자가 직접 로그아웃할 때만 `PATCH /auth/kakao` 를 부른다 (실패는 무시).
  /// 만료/탈퇴는 서버 세션이 이미 없어 부르지 않는다.
  Future<void> logout(LogoutReason reason) async {
    if (reason == LogoutReason.user) {
      try {
        await _dio.patch<void>(
          '/auth/kakao',
          options: Options(extra: {AuthExtra.skipRefresh: true}),
        );
      } on DioException catch (e) {
        debugPrint('logout: PATCH /auth/kakao 실패 무시 (${e.message})');
      }
    }
    await _storage.clear();
    try {
      await ref.read(clearWebViewCookiesProvider)();
    } on Exception catch (e) {
      debugPrint('logout: WebView 쿠키 삭제 실패 무시 ($e)');
    }
    // currentUserIdProvider 를 watch 하는 provider 는 이 변경으로 다시 만들어진다.
    state = AuthState.loggedOut(reason: reason);
  }

  /// `DELETE /withdraw` 후 로그아웃한다. 탈퇴 요청이 실패하면 로그인 상태를 유지한다.
  Future<void> withdraw() async {
    await _dio.delete<void>('/withdraw');
    await logout(LogoutReason.withdraw);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
