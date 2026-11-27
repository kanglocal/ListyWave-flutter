import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/env.dart';

/// 카카오 메시지 템플릿 id (web `kakaotalkShare.ts`).
const kakaoListTemplateId = 103935;

/// 갤러리 저장 실패 사유.
enum SaveImageFailure { accessDenied, other }

class SaveImageException implements Exception {
  const SaveImageException(this.failure);

  final SaveImageFailure failure;
}

/// 공유와 갤러리 저장에 쓰는 platform 기능 (클립보드, OS 공유, 카카오톡, gal).
/// 테스트에서는 provider 를 override 해서 호출만 기록한다.
class ShareService {
  const ShareService(this._env);

  final Env _env;

  /// web `copyUrl.ts`.
  Future<void> copyText(String text) =>
      Clipboard.setData(ClipboardData(text: text));

  /// OS 공유 시트 (share_plus). iPad 는 시트를 띄울 위치 [origin] 이 필요하다.
  Future<void> shareText(String text, {String? subject, Rect? origin}) =>
      SharePlus.instance.share(
        ShareParams(text: text, subject: subject, sharePositionOrigin: origin),
      );

  /// 카카오 SDK 를 쓸 수 있는가 (`KAKAO_NATIVE_APP_KEY` 로 초기화했는가).
  bool get isKakaoAvailable => _env.kakaoNativeAppKey.isNotEmpty;

  /// web `kakaotalkShare.ts` `Kakao.Share.sendCustom`. 카카오톡이 없으면 웹 공유 페이지로 연다.
  Future<void> shareKakao(Map<String, String> templateArgs) async {
    if (await ShareClient.instance.isKakaoTalkSharingAvailable()) {
      await ShareClient.instance.shareCustom(
        templateId: kakaoListTemplateId,
        templateArgs: templateArgs,
      );
      return;
    }
    final url = await WebSharerClient.instance.makeCustomUrl(
      templateId: kakaoListTemplateId,
      templateArgs: templateArgs,
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  /// PNG 를 갤러리에 저장한다. 권한이 없으면 요청하고, 거절되면
  /// [SaveImageFailure.accessDenied] 로 실패한다.
  Future<void> saveImageToGallery(Uint8List png, {required String name}) async {
    try {
      if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
        throw const SaveImageException(SaveImageFailure.accessDenied);
      }
      await Gal.putImageBytes(png, name: name);
    } on GalException catch (e) {
      throw SaveImageException(
        e.type == GalExceptionType.accessDenied
            ? SaveImageFailure.accessDenied
            : SaveImageFailure.other,
      );
    }
  }
}

/// 카카오 SDK 가 받은 `kakao{KEY}://kakaolink?…` 앱 실행 URL 을 [onLink] 로 넘긴다.
/// iOS 에서는 카카오 plugin 이 이 URL 을 먼저 처리해서 (`application(_:open:)` 이 true) Flutter
/// deep linking 으로 router 에 오지 않으므로 이 경로로 받는다 (PLAN §2.1). Android 는 두 경로로 다
/// 오지만 같은 위치로 `go` 하므로 결과가 같다. 테스트는 override 해서 직접 URL 을 넣는다.
typedef KakaoSchemeReceiver = void Function(void Function(Uri uri) onLink);

final kakaoSchemeReceiverProvider = Provider<KakaoSchemeReceiver>(
  (ref) => receiveKakaoScheme,
);

final shareServiceProvider = Provider<ShareService>(
  (ref) => ShareService(ref.watch(envProvider)),
);

/// web `kakaotalkShare.ts` 와 같은 template 인자.
Map<String, String> kakaoListTemplateArgs({
  required int listId,
  required String title,
  required String? description,
  required List<String> itemTitles,
  required String ownerNickname,
  required List<String> collaboratorNicknames,
}) => {
  'title': title,
  'description': description ?? '',
  'listId': '$listId',
  'itemTitle1': itemTitles.elementAtOrNull(0) ?? '',
  'itemTitle2': itemTitles.elementAtOrNull(1) ?? '',
  'itemTitle3': itemTitles.elementAtOrNull(2) ?? '',
  'allWriter': [ownerNickname, ...collaboratorNicknames].join(','),
};
