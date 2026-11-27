import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/env.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/share/share_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/app_network_image.dart';

/// web `SaveImageModal.tsx`: 리스트를 이미지로 만들어 갤러리에 저장한다
/// (RepaintBoundary → PNG → gal, PLAN §6).
///
/// 저장되는 이미지는 web 캡처와 같은 모양이다: 폭 [_captureWidth], 안쪽 여백 50/30, 흰 배경,
/// 프로필·닉네임·수정 시각 → 구분선 → 배경색 상자(제목, 순번·아이템·사진) → 로고와 작성자·저장 날짜·주소.
/// 미리보기는 저장될 이미지를 그대로 줄여서 보여준다.
Future<void> showSaveImageDialog(
  BuildContext context, {
  required ListDetailType list,
}) => showDialog<void>(
  context: context,
  useRootNavigator: true,
  builder: (_) => SaveImageDialog(list: list),
);

/// web `CAPTURE_WIDTH`.
const double _captureWidth = 390;

class SaveImageDialog extends ConsumerStatefulWidget {
  const SaveImageDialog({super.key, required this.list});

  final ListDetailType list;

  @override
  ConsumerState<SaveImageDialog> createState() => _SaveImageDialogState();
}

class _SaveImageDialogState extends ConsumerState<SaveImageDialog> {
  final _boundaryKey = GlobalKey();

  /// web 처럼 화면을 연 시점의 날짜로 한 번만 정한다.
  final _savedAt = DateTime.now();
  bool _saving = false;

  /// 캡처 전에 사진이 다 불러와질 때까지 기다린다 (web `waitForImages`). 실패한 사진은 건너뛴다.
  Future<void> _waitForImages() {
    final provider = ref.read(networkImageProvider);
    final urls = [
      widget.list.ownerProfileImageUrl,
      for (final item in widget.list.items) item.imageUrl,
    ].whereType<String>().where((url) => url.isNotEmpty);
    return Future.wait([
      for (final url in urls)
        precacheImage(provider(url), context, onError: (_, _) {}),
    ]);
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    String message;
    try {
      await _waitForImages();
      final boundary =
          _boundaryKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      await ref
          .read(shareServiceProvider)
          .saveImageToGallery(
            bytes!.buffer.asUint8List(),
            name: 'listywave_${DateTime.now().millisecondsSinceEpoch}',
          );
      message = l10n.toast_saveImageSuccess;
      navigator.pop();
    } on SaveImageException catch (e) {
      message = e.failure == SaveImageFailure.accessDenied
          ? l10n.toast_saveImagePermissionDenied
          : l10n.toast_saveImageFailed;
    } on Object {
      message = l10n.toast_saveImageFailed;
    }
    if (mounted) setState(() => _saving = false);
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                // 저장될 이미지(폭 390)를 그대로 줄여서 보여준다. RepaintBoundary 는 부모의 축소와
                // 상관없이 자기 크기(390 × pixelRatio)로 찍힌다.
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RepaintBoundary(
                    key: _boundaryKey,
                    child: SaveImageCapture(
                      list: widget.list,
                      savedAt: _savedAt,
                      siteHost: siteHostOf(ref.watch(envProvider).siteUrl),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.common_cancel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    key: const Key('saveImage.save'),
                    onPressed: _saving ? null : _save,
                    child: Text(l10n.listDetail_saveImage),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// web `SITE_HOST = new URL(DOMAIN_URL).host` (기본 포트가 아니면 포트 포함).
@visibleForTesting
String siteHostOf(String siteUrl) {
  final uri = Uri.tryParse(siteUrl);
  if (uri == null || uri.host.isEmpty) return siteUrl;
  return uri.hasPort ? '${uri.host}:${uri.port}' : uri.host;
}

/// web `formatSavedDate` (예: 2026.11.27).
String _formatSavedDate(DateTime date) => DateFormat('yyyy.MM.dd').format(date);

/// web `new Date(lastUpdatedDate).toLocaleString()`.
/// ko: `2026. 11. 27. 오후 3:37:30`, 그 밖: `11/27/2026 3:37:30 PM`.
@visibleForTesting
String formatUpdatedDate(String raw, Locale locale) {
  final date = DateTime.tryParse(raw);
  if (date == null) return raw;
  final local = date.toLocal();
  if (locale.languageCode == 'ko') {
    return DateFormat('y. M. d. a h:mm:ss', 'ko').format(local);
  }
  return DateFormat.yMd(locale.toString()).add_jms().format(local);
}

/// 저장되는 이미지. web `SaveImageModal` 의 captureContent 를 캡처용 clone 스타일
/// (폭 390, padding 50px 30px, 흰 배경) 그대로 옮겼다. 1rem = 10px.
@visibleForTesting
class SaveImageCapture extends ConsumerWidget {
  const SaveImageCapture({
    super.key,
    required this.list,
    required this.savedAt,
    required this.siteHost,
  });

  final ListDetailType list;
  final DateTime savedAt;
  final String siteHost;

  static const _brandMetaStyle = TextStyle(
    fontSize: 10,
    height: 1.3,
    color: Color(0xFF8599AD),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final imageOf = ref.watch(networkImageProvider);
    final locale = Localizations.localeOf(context);
    return Container(
      key: const Key('saveImage.capture'),
      width: _captureWidth,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          color: AppColors.black,
          fontSize: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // header: 36px 칸에 40px 프로필 (web 처럼 칸 밖으로 4px 넘친다), 닉네임 + 수정 시각
            Row(
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: _ProfileImage(
                          url: list.ownerProfileImageUrl,
                          imageOf: imageOf,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list.ownerNickname,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray2,
                        ),
                      ),
                      Text(
                        formatUpdatedDate(list.lastUpdatedDate, locale),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.lightgray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // header margin-bottom 15 + hr 기본 margin-top 0.5em(5px), 선 1px, margin-bottom 30
            const SizedBox(height: 20),
            const ColoredBox(color: AppColors.line, child: SizedBox(height: 1)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    ListBackgroundColors.read[list.backgroundColor] ??
                    AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    list.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final (index, item) in list.items.indexed) ...[
                          if (index > 0) const SizedBox(height: 12),
                          _CaptureItem(
                            index: index,
                            title: item.title,
                            imageUrl: item.imageUrl,
                            imageOf: imageOf,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // brand: 로고와 작성자·저장 날짜·주소 (작고 흐리게)
            const SizedBox(height: 16),
            Opacity(
              opacity: 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/png/large_logo.png',
                    width: 82,
                    height: 14,
                    semanticLabel: 'ListyWave',
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.saveImage_brandMeta(
                            list.ownerNickname,
                            _formatSavedDate(savedAt),
                          ),
                          style: _brandMetaStyle,
                        ),
                        const SizedBox(height: 2),
                        Text(siteHost, style: _brandMetaStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.url, required this.imageOf});

  final String? url;
  final ImageProvider Function(String url) imageOf;

  @override
  Widget build(BuildContext context) {
    const size = 40.0;
    final fallback = Image.asset(
      'assets/images/fallback_profileImage.webp',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
    final src = url;
    return ClipOval(
      child: src == null || src.isEmpty
          ? fallback
          : Image(
              image: imageOf(src),
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => fallback,
            ),
    );
  }
}

/// web listItem: 높이 6rem, padding 10px 0, `1.` 굵게 + 제목 + 오른쪽 50px 사진.
class _CaptureItem extends StatelessWidget {
  const _CaptureItem({
    required this.index,
    required this.title,
    required this.imageUrl,
    required this.imageOf,
  });

  final int index;
  final String title;
  final String? imageUrl;
  final ImageProvider Function(String url) imageOf;

  @override
  Widget build(BuildContext context) {
    final src = imageUrl;
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              '${index + 1}.',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (src != null && src.isNotEmpty)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: imageOf(src),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox(
                      width: 50,
                      height: 50,
                      child: ColoredBox(color: Color(0xFFEFEFEF)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
