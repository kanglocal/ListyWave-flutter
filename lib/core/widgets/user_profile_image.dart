import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_network_image.dart';

/// web `src/components/UserProfileImage`. 이미지가 없거나 깨지면 기본 프로필을 그린다.
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
    final fallback = SvgPicture.asset(
      'assets/icons/default_profile.svg',
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
