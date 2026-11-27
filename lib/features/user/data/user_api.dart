import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/list_type.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// `GET /users/{userId}/lists?type=` 값.
enum UserListType { my, collabo }

/// web `_api/user/*.ts` (조회, 프로필 수정, 닉네임 검사, 기본 이미지, 이미지 업로드),
/// `_api/list/getAllList.ts`.
class UserApi {
  const UserApi(this._dio);

  final Dio _dio;

  static const listPageSize = 10;

  Future<UserType> getUserOne(int userId) async {
    final response = await _dio.get<Object?>('/users/$userId');
    return UserType.fromJson(asJsonMap(response.data));
  }

  Future<AllListType> getAllList(
    int userId, {
    required UserListType type,
    required String category,
    String? cursorUpdatedDate,
  }) async {
    final response = await _dio.get<Object?>(
      '/users/$userId/lists',
      queryParameters: {
        'type': type.name,
        'category': category,
        'size': listPageSize,
        'cursorUpdatedDate': ?cursorUpdatedDate,
      },
    );
    return AllListType.fromJson(asJsonMap(response.data));
  }

  /// backend `UserProfileUpdateRequest{nickname, description, profileImageUrl, backgroundImageUrl}`
  /// (204). null 인 값은 backend 가 바꾸지 않으므로 보내지 않는다.
  Future<void> updateProfile(
    int userId, {
    String? nickname,
    String? description,
    String? profileImageUrl,
    String? backgroundImageUrl,
  }) => _dio.patch<void>(
    '/users/$userId',
    data: {
      'nickname': ?nickname,
      'description': ?description,
      'profileImageUrl': ?profileImageUrl,
      'backgroundImageUrl': ?backgroundImageUrl,
    },
  );

  /// 이미 쓰는 닉네임이면 true (대소문자 무시, `UserService.isDuplicateNickname`).
  Future<bool> isNicknameDuplicated(String nickname) async {
    final response = await _dio.get<Object?>(
      '/users/exists',
      queryParameters: {'nickname': nickname},
    );
    return response.data == true;
  }

  /// 닉네임 정책 (금칙어 등) 을 통과하면 true. backend 는 통과하면 200, 아니면 400 이다.
  Future<bool> isNicknameAllowed(String nickname) async {
    try {
      await _dio.get<void>(
        '/users/nickname-validate',
        queryParameters: {'nickname': nickname},
      );
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) return false;
      rethrow;
    }
  }

  Future<List<DefaultImageType>> getDefaultProfileImages() async {
    final response = await _dio.get<Object?>('/users/default-profile-images');
    return asJsonList(response.data, DefaultImageType.fromJson);
  }

  Future<List<DefaultImageType>> getDefaultBackgroundImages() async {
    final response = await _dio.get<Object?>(
      '/users/default-background-images',
    );
    return asJsonList(response.data, DefaultImageType.fromJson);
  }

  /// backend `UserImageUpdateRequest{profileExtension, backgroundExtension}` →
  /// `UserPresignedUrlCreateResponse`. 고르지 않은 쪽은 빈 문자열이 온다.
  Future<({String profile, String background})> createImageUploadUrls({
    String? profileExtension,
    String? backgroundExtension,
  }) async {
    final response = await _dio.post<Object?>(
      '/users/upload-url',
      data: _imageExtensions(profileExtension, backgroundExtension),
    );
    final json = asJsonMap(response.data);
    return (
      profile: json['profilePresignedUrl'] as String? ?? '',
      background: json['backgroundPresignedUrl'] as String? ?? '',
    );
  }

  /// 업로드한 이미지를 프로필에 반영한다 (204).
  Future<void> completeImageUpload({
    String? profileExtension,
    String? backgroundExtension,
  }) => _dio.post<void>(
    '/users/upload-complete',
    data: _imageExtensions(profileExtension, backgroundExtension),
  );

  Map<String, String> _imageExtensions(String? profile, String? background) => {
    'profileExtension': ?profile,
    'backgroundExtension': ?background,
  };
}

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(ref.watch(dioProvider)),
);
