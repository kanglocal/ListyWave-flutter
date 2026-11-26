import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/share/share_service.dart';

import 'pump_app.dart';
import 'read_api_mocks.dart';

/// 서버 오류 응답. [delay] 동안 낙관적 값이 화면에 보이는지 확인할 수 있다.
const serverErrorDelay = Duration(milliseconds: 100);

Map<String, Object> serverErrorBody() => {
  'status': 500,
  'error': 'INTERNAL_SERVER_ERROR',
  'code': 'INTERNAL_SERVER_ERROR',
  'detail': 'boom',
  'message': 'boom',
};

/// [userId] 로 로그인한 (null 이면 비로그인) 앱을 조회 mock 과 함께 띄운다.
/// 세션 확인 `GET /users/{userId}` 는 fixture 또는 최소 응답으로 받는다.
Future<(ProviderContainer, ApiMock)> pumpWithApi(
  WidgetTester tester, {
  int? userId,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
  void Function(ApiMock api)? onMock,
}) async {
  late ApiMock api;
  final container = await pumpApp(
    tester,
    secure: userId == null ? null : {'accessToken': 'at', 'refreshToken': 'rt'},
    prefs: {'userId': ?userId, ...prefs},
    overrides: overrides,
    beforePump: (c) {
      api = ApiMock(c);
      if (userId != null && userId != 9 && userId != 3) {
        api.adapter.onGet(
          '/users/$userId',
          (s) => s.reply(200, {'id': userId}),
        );
      }
      mockReadApis(api);
      onMock?.call(api);
    },
  );
  return (container, api);
}

/// 쓰기 요청 (POST/PATCH/PUT/DELETE) 만.
List<String> writesOf(ApiMock api) => [
  for (final r in api.requests)
    if (r.method != 'GET') '${r.method} ${r.uri.path}',
];

/// platform channel 대신 호출을 기록하는 [ShareService].
class FakeShareService extends ShareService {
  FakeShareService() : super(testEnv);

  final copied = <String>[];
  final shared = <String>[];
  final kakaoArgs = <Map<String, String>>[];
  final savedImages = <String>[];

  /// true 면 카카오 SDK 를 초기화한 것처럼 둔다.
  bool kakaoAvailable = true;
  SaveImageException? saveError;

  @override
  Future<void> copyText(String text) async => copied.add(text);

  @override
  Future<void> shareText(
    String text, {
    String? subject,
    Object? origin,
  }) async => shared.add(text);

  @override
  bool get isKakaoAvailable => kakaoAvailable;

  @override
  Future<void> shareKakao(Map<String, String> templateArgs) async =>
      kakaoArgs.add(templateArgs);

  @override
  Future<void> saveImageToGallery(List<int> png, {required String name}) async {
    if (saveError case final error?) throw error;
    savedImages.add(name);
  }
}
