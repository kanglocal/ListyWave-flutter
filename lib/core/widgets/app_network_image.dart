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
class AppNetworkImage extends ConsumerWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallback,
    this.semanticLabel,
  });

  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? fallback;
  final String? semanticLabel;

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
    return Image(
      image: ref.watch(networkImageProvider)(src),
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}
