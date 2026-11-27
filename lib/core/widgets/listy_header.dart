import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';
import '../theme/app_theme.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

/// web `src/components/Header/Header.tsx` (3.0): 높이 50, `bggray` 바탕, 가운데 `Subtitle` 제목,
/// 오른쪽 글자 버튼은 `BodyRegular` `bluegray10`. web 의 "뒤로가기" 글자 대신 ← 아이콘을 쓴다.
/// iOS 의 swipe-back 은 route 가 처리하므로 그대로 동작한다.
class ListyHeader extends StatelessWidget implements PreferredSizeWidget {
  const ListyHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.actions = const [],
    this.leading,
    this.onBack,
    this.showBack = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget> actions;

  /// 뒤로가기 대신 둘 위젯 (예: 닫기 ×).
  final Widget? leading;

  /// 기본은 `Navigator.maybePop`.
  final VoidCallback? onBack;

  /// false 면 왼쪽을 비운다. true 라도 돌아갈 곳이 없고 [onBack] 이 없으면 비운다.
  final bool showBack;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(AppTheme.headerHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;
    final back = showBack && (onBack != null || canPop)
        ? ListyBackButton(onPressed: onBack, color: foregroundColor)
        : null;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      leading: leading ?? back,
      title:
          titleWidget ??
          (title == null
              ? null
              : Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.subtitle.copyWith(
                    color: foregroundColor ?? AppColors.black,
                  ),
                )),
      actions: [...actions, const SizedBox(width: 4)],
    );
  }
}

/// [ListyHeader] 의 ← 버튼.
class ListyBackButton extends StatelessWidget {
  const ListyBackButton({super.key, this.onPressed, this.color});

  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('header.back'),
      tooltip: AppLocalizations.of(context).common_back,
      icon: Icon(Icons.arrow_back, color: color ?? AppColors.black2),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}

/// [ListyHeader] 오른쪽 글자 버튼. web `Header.css.ts` rightChild: `BodyRegular` `bluegray10`,
/// 비활성은 `bluegray6` (`list/create/_components/Step.css.ts` nextButton).
/// 테스트가 `TextButton` 으로 찾을 수 있게 [key] 를 TextButton 에 그대로 단다.
TextButton listyHeaderTextButton(
  BuildContext context, {
  Key? key,
  required String label,
  required VoidCallback? onPressed,
  bool busy = false,
}) {
  return TextButton(
    key: key,
    onPressed: onPressed,
    style: TextButton.styleFrom(
      foregroundColor: AppColors.bluegray10,
      disabledForegroundColor: AppColors.bluegray6,
      textStyle: context.typo.bodyRegular,
    ),
    child: busy
        ? const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label),
  );
}
