import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/current_user.dart';
import '../core/l10n/gen/app_localizations.dart';
import '../core/theme/colors.dart';
import '../core/theme/typography.dart';
import 'router.dart';

/// web `src/components/BottomNav/BottomNav.tsx` 를 옮긴 하단 탭 shell.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  /// web 과 같이 `/` 와 `.../mylist` 에서만 하단 탭을 보인다.
  static bool isBottomNavVisible(String location) =>
      location == AppRoutes.home || location.endsWith('/mylist');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: isBottomNavVisible(location)
          ? AppBottomNav(
              location: location,
              userId: ref.watch(currentUserIdProvider),
            )
          : null,
    );
  }
}

enum _Tab { home, feed }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.location, required this.userId});

  final String location;
  final int? userId;

  _Tab get _selected =>
      userId != null && location == AppRoutes.myList('$userId')
      ? _Tab.feed
      : _Tab.home;

  /// 로그인 사용자만 이동한다. 아니면 로그인 dialog 를 띄운다 (web 과 같음).
  void _goOnLogin(BuildContext context, String Function(int userId) path) {
    final id = userId;
    if (id == null) {
      context.push(AppRoutes.login);
      return;
    }
    context.go(path(id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ColoredBox(
      color: AppColors.bggray,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _NavItem(
                  icon: 'assets/icons/new/bottom_nav_home.svg',
                  label: l10n.bottomNav_home,
                  selected: _selected == _Tab.home,
                  onTap: () => context.go(AppRoutes.home),
                ),
              ),
              Expanded(
                child: Center(
                  child: Semantics(
                    button: true,
                    label: l10n.bottomNav_add,
                    child: InkResponse(
                      key: const Key('bottomNav.add'),
                      onTap: () =>
                          _goOnLogin(context, (_) => AppRoutes.listCreate),
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF428AF7), Color(0xFF6CA5F7)],
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/new/bottom_nav_add.svg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: _NavItem(
                  icon: 'assets/icons/new/bottom_nav_feed.svg',
                  label: l10n.bottomNav_myFeed,
                  selected: _selected == _Tab.feed,
                  onTap: () =>
                      _goOnLogin(context, (id) => AppRoutes.myList('$id')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              selected ? AppColors.blue : AppColors.lightgray,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.typo.label.copyWith(
              fontSize: 12,
              color: selected ? AppColors.blue : AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
