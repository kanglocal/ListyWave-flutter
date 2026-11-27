import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/env.dart';
import '../l10n/gen/app_localizations.dart';
import '../share/share_service.dart';
import '../theme/colors.dart';
import 'toast.dart';

/// web `components/floatingButton/*` (홈, 마이/콜라보 리스트, 검색).
/// 오른쪽 아래에 링크 공유 버튼(56)을, 700 넘게 내려가면 그 위에 맨 위로 버튼(44)을 띄운다.
/// 스크롤은 [child] 안 첫 세로 Scrollable 의 알림으로 따라가므로 controller 가 필요 없다.
class FloatingButtonsScope extends StatefulWidget {
  const FloatingButtonsScope({
    super.key,
    required this.sharePath,
    required this.child,
    this.bottom = 16,
  });

  /// 공유할 web 경로 (예: `/`, `/user/3/mylist`). `siteUrl` 뒤에 붙인다.
  final String sharePath;
  final Widget child;
  final double bottom;

  @override
  State<FloatingButtonsScope> createState() => _FloatingButtonsScopeState();
}

class _FloatingButtonsScopeState extends State<FloatingButtonsScope> {
  /// web `ArrowUpButton.tsx` 의 `window.scrollY < 700`.
  static const _showArrowAfter = 700.0;

  ScrollPosition? _position;
  bool _showArrow = false;

  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final context = n.context;
    if (context != null) _position = Scrollable.maybeOf(context)?.position;
    final show = n.metrics.pixels >= _showArrowAfter;
    if (show != _showArrow) setState(() => _showArrow = show);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: widget.child,
        ),
        Positioned(
          right: 16,
          bottom: widget.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _showArrow
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: _CircleButton(
                          key: const Key('floating.arrowUp'),
                          size: 44,
                          tooltip: l10n.common_goTop,
                          onTap: () => _position?.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/new/arrow_up.svg',
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              _ShareLinkButton(path: widget.sharePath),
            ],
          ),
        ),
      ],
    );
  }
}

/// web `ShareLinkButton.tsx`: 지금 페이지 링크를 복사한다.
class _ShareLinkButton extends ConsumerWidget {
  const _ShareLinkButton({required this.path});

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return _CircleButton(
      key: const Key('floating.share'),
      size: 56,
      tooltip: l10n.common_shareLink,
      onTap: () async {
        final url = '${ref.read(envProvider).siteUrl}$path';
        try {
          await ref.read(shareServiceProvider).copyText(url);
          if (context.mounted) showToast(context, l10n.toast_copyLink);
        } on Exception {
          if (context.mounted) showToast(context, l10n.toast_failedCopyLink);
        }
      },
      child: SvgPicture.asset('assets/icons/new/share.svg'),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    super.key,
    required this.size,
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  final double size;
  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            // web FloatingContainer.css.ts basicButton 의 box-shadow 두 겹.
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Color(0x0A8E8E8E), blurRadius: 4),
                BoxShadow(
                  color: Color(0x14747474),
                  offset: Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
