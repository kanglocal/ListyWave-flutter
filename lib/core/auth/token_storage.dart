import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 토큰은 secure storage, userId 는 shared_preferences 에 둔다 (PLAN §4.3).
/// 요청마다 Keychain 을 읽지 않도록 토큰은 메모리에도 들고 있는다.
class TokenStorage {
  TokenStorage({
    FlutterSecureStorage secure = const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
    Future<SharedPreferences>? prefs,
  }) : _secure = secure,
       _prefs = prefs ?? SharedPreferences.getInstance();

  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _userIdKey = 'userId';

  final FlutterSecureStorage _secure;
  final Future<SharedPreferences> _prefs;

  bool _loaded = false;
  String? _accessToken;
  String? _refreshToken;

  Future<void> _load() async {
    if (_loaded) return;
    _accessToken = await _secure.read(key: _accessTokenKey);
    _refreshToken = await _secure.read(key: _refreshTokenKey);
    _loaded = true;
  }

  Future<String?> readAccessToken() async {
    await _load();
    return _accessToken;
  }

  Future<String?> readRefreshToken() async {
    await _load();
    return _refreshToken;
  }

  Future<int?> readUserId() async => (await _prefs).getInt(_userIdKey);

  Future<void> save({
    required int userId,
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _loaded = true;
    await _secure.write(key: _accessTokenKey, value: accessToken);
    await _secure.write(key: _refreshTokenKey, value: refreshToken);
    await (await _prefs).setInt(_userIdKey, userId);
  }

  Future<void> saveAccessToken(String accessToken) async {
    _accessToken = accessToken;
    _loaded = true;
    await _secure.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _loaded = true;
    await _secure.delete(key: _accessTokenKey);
    await _secure.delete(key: _refreshTokenKey);
    await (await _prefs).remove(_userIdKey);
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
