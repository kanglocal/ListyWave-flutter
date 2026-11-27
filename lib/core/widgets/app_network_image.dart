import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// URL → [ImageProvider]. 기본은 디스크 캐시를 쓰는 [CachedNetworkImageProvider] 다
/// (web `next/image` 대체, PLAN §6). 테스트는 네트워크 없이 그리도록 override 한다.
final networkImageProvider = Provider<ImageProvider Function(String url)>(
  (ref) =>
      (url) => CachedNetworkImageProvider(url),
);

/// 네트워크 이미지. 불러오지 못하면 [fallback] 을 (없으면 회색 상자) 그린다.
///
/// 원본 (최대 50MB 업로드) 을 그대로 decode 하지 않도록 메모리 캐시에는 그리는 폭만큼만
/// decode 한다: [memCacheWidth] → 유한한 [width] → 화면 폭 순서로 정한 논리 px 에
/// devicePixelRatio 를 곱한다. 원본보다 키우지는 않는다 ([ResizeImage] 기본값).
class AppNetworkImage extends ConsumerWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallback,
    this.semanticLabel,
    this.memCacheWidth,
  });

  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? fallback;
  final String? semanticLabel;

  /// decode 할 폭 (논리 px). 폭이 정해지지 않은 grid 썸네일처럼 화면 폭보다 작게 그려지는
  /// 이미지에 준다.
  final double? memCacheWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeholder =
        fallback ??
        SizedBox(
          width: width,
          height: height,
          child: const ColoredBox(color: Color(0xFFEFEFEF)),
        );
    final src = url;
    if (src == null || src.isEmpty) return placeholder;
    final logicalWidth =
        memCacheWidth ??
        (width != null && width!.isFinite
            ? width!
            : MediaQuery.sizeOf(context).width);
    final cacheWidth = (logicalWidth * MediaQuery.devicePixelRatioOf(context))
        .round();
    return Image(
      image: ResizeImage.resizeIfNeeded(
        cacheWidth > 0 ? cacheWidth : null,
        null,
        ref.watch(networkImageProvider)(src),
      ),
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}
