import 'package:flutter/material.dart';

import 'app_network_image.dart';

/// 사용자 프로필 원형 이미지. 이미지가 없거나 깨지면 기본 프로필을 그린다.
/// 기본 프로필은 web 3.0 피드·상세·추천 리스터·마이리스트가 쓰는 `fallback_profileImage.webp` 다.
class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.src,
    required this.size,
    this.semanticLabel,
  });

  final String? src;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(
      'assets/images/fallback_profileImage.webp',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: AppNetworkImage(
          url: src,
          width: size,
          height: size,
          fallback: fallback,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}
