/// 백엔드 `auth/application/dto/LoginResponse.java`. 앱이 쓰는 값만 읽는다.
class LoginResponse {
  const LoginResponse({
    required this.id,
    required this.isFirst,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    id: (json['id'] as num).toInt(),
    isFirst: json['isFirst'] as bool? ?? false,
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );

  final int id;

  /// 처음 가입한 사용자면 true 다. 앱은 `/start-listy` 로 보낸다.
  final bool isFirst;
  final String accessToken;
  final String refreshToken;
}
