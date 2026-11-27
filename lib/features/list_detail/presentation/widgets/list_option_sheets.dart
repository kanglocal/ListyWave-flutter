import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/env.dart';
import '../../../../app/router.dart';
import '../../../../core/auth/current_user.dart';
import '../../../../core/auth/require_login.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/share/share_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/toast.dart';
import '../../../report/data/report_api.dart';
import '../../../report/presentation/report_sheet.dart';
import 'save_image_dialog.dart';

/// 공유 URL (web `DOMAIN_URL + path`).
String listShareUrl(Env env, int listId) => '${env.siteUrl}/list/$listId';

/// web `BottomSheet` 의 한 줄.
class SheetOption {
  const SheetOption({
    required this.key,
    required this.title,
    required this.onTap,
    this.color,
  });

  final Key key;
  final String title;
  final VoidCallback onTap;
  final Color? color;
}

Future<void> showOptionSheet(BuildContext context, List<SheetOption> options) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in options)
              ListTile(
                key: option.key,
                title: Text(
                  option.title,
                  textAlign: TextAlign.center,
                  style: context.typo.body.copyWith(
                    color: option.color ?? AppColors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  option.onTap();
                },
              ),
          ],
        ),
      ),
    );

/// web `getBottomSheetOptionList.ts` type 'share'. 비공개 리스트는 카카오톡 공유를 뺀다.
/// 앱은 OS 공유 시트(share_plus) 를 더한다 (PLAN §6).
Future<void> showShareSheet(
  BuildContext context, {
  required ListDetailType list,
  required int listId,
}) {
  final l10n = AppLocalizations.of(context);
  final container = ProviderScope.containerOf(context, listen: false);
  final share = container.read(shareServiceProvider);
  final url = listShareUrl(container.read(envProvider), listId);
  final box = context.findRenderObject() as RenderBox?;
  final origin = box == null ? null : box.localToGlobal(Offset.zero) & box.size;

  Future<void> run(Future<void> Function() action, String failed) async {
    try {
      await action();
    } on Object {
      if (context.mounted) showToast(context, failed);
    }
  }

  return showOptionSheet(context, [
    SheetOption(
      key: const Key('share.copyLink'),
      title: l10n.listDetail_copyListLink,
      onTap: () => run(() async {
        await share.copyText(url);
        if (context.mounted) showToast(context, l10n.toast_copyLink);
      }, l10n.toast_failedCopyLink),
    ),
    if (list.isPublic)
      SheetOption(
        key: const Key('share.kakao'),
        title: l10n.listDetail_shareListToKakaotalk,
        onTap: () {
          if (!share.isKakaoAvailable) {
            showToast(context, l10n.toast_kakaoShareUnavailable);
            return;
          }
          run(
            () => share.shareKakao(
              kakaoListTemplateArgs(
                listId: listId,
                title: list.title,
                description: list.description,
                itemTitles: list.items.map((i) => i.title).toList(),
                ownerNickname: list.ownerNickname,
                collaboratorNicknames: list.collaborators
                    .where((c) => c.id != list.ownerId)
                    .map((c) => c.nickname)
                    .toList(),
              ),
            ),
            l10n.toast_kakaoShareFailed,
          );
        },
      ),
    SheetOption(
      key: const Key('share.os'),
      title: l10n.listDetail_shareOther,
      onTap: () => run(
        () => share.shareText(url, subject: list.title, origin: origin),
        l10n.toast_shareFailed,
      ),
    ),
  ]);
}

/// web `getBottomSheetOptionList.ts` type 'etc': 이미지로 저장, 이 타이틀로 리스트 생성,
/// 남의 리스트면 신고하기 (비로그인은 누르면 로그인 sheet).
/// 생성 화면 프리필은 web 과 같이 `category` 에 카테고리 한글 이름을 넘긴다 (`StepOne.tsx`).
Future<void> showEtcSheet(
  BuildContext context, {
  required ListDetailType list,
  required int listId,
}) {
  final l10n = AppLocalizations.of(context);
  final me = ProviderScope.containerOf(
    context,
    listen: false,
  ).read(currentUserIdProvider);
  return showOptionSheet(context, [
    SheetOption(
      key: const Key('etc.saveImage'),
      title: l10n.listDetail_saveListToImage,
      onTap: () => showSaveImageDialog(context, list: list),
    ),
    SheetOption(
      key: const Key('etc.createWithTitle'),
      title: l10n.listDetail_createListToThisTitle,
      onTap: () {
        if (requireLogin(context) == null) return;
        showToast(context, l10n.listDetail_moveToCreateListPageMessage);
        context.push(
          Uri(
            path: AppRoutes.listCreate,
            queryParameters: {
              'title': list.title,
              'category': list.categoryKorName,
            },
          ).toString(),
        );
      },
    ),
    if (me != list.ownerId)
      SheetOption(
        key: const Key('etc.report'),
        title: l10n.listDetail_reportList,
        onTap: () {
          if (requireLogin(context) == null) return;
          showReportSheet(
            context,
            targetType: ReportTargetType.list,
            targetId: listId,
          );
        },
      ),
  ]);
}
