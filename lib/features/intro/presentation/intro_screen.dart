import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/link_preview.dart';

/// web `/intro` (Section1~7 + Footer). framer-motion 은 flutter_animate 로 옮겼다 (PLAN §6).
/// web 처럼 화면에 들어올 때 나타나도록 lazy [ListView] 안에서 각 섹션이 build 될 때 재생한다.
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  static const privacyUrl =
      'https://cypress-tv-724.notion.site/2118cc63884e4365b753cac553f3f7ed?pvs=4';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        key: const Key('intro.scroll'),
        padding: EdgeInsets.zero,
        children: [
          const _HeroSection(),
          _MessageSection(
            background: AppColors.whiteblue,
            titles: [l10n.intro_message1, l10n.intro_message2],
            trailing: Text(
              'LISTY WAVE',
              style: context.typo.header.copyWith(
                fontSize: 36,
                color: AppColors.blue,
              ),
            ),
          ),
          _MessageSection(
            background: AppColors.white,
            titles: [l10n.intro_message3, l10n.intro_message4],
            subtitles: [l10n.intro_message5, l10n.intro_message6],
          ),
          _MessageSection(
            background: AppColors.whiteblue,
            titles: [l10n.intro_message7, l10n.intro_message8],
            subtitles: [
              l10n.intro_message9,
              l10n.intro_message10,
              l10n.intro_message11,
            ],
          ),
          _MessageSection(
            background: AppColors.white,
            sectionName: l10n.intro_message17,
            titles: [
              '${l10n.intro_message12} ${l10n.intro_message13}',
              l10n.intro_message14,
            ],
            subtitles: [l10n.intro_message15, l10n.intro_message16],
            trailing: const _LabelsAnimation(),
          ),
          _MessageSection(
            background: AppColors.whiteblue,
            titles: [l10n.intro_message21],
            subtitles: [
              l10n.intro_message18,
              l10n.intro_message19,
              l10n.intro_message20,
            ],
            trailing: const _SearchTicker(),
          ),
          _MessageSection(
            background: AppColors.white,
            sectionName: l10n.intro_message22,
            titles: [l10n.intro_message23, l10n.intro_message24],
            subtitles: [
              l10n.intro_message25,
              l10n.intro_message26,
              l10n.intro_message27,
            ],
          ),
          const _Footer(),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    const words = ["What's", 'In', 'Your', 'List'];
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.go(AppRoutes.home),
            child: SvgPicture.asset('assets/icons/logo.svg', height: 28),
          ),
          const SizedBox(height: 32),
          Image.asset(
            'assets/images/wave_surf.png',
            height: 280,
          ).animate().fadeIn(duration: 1.seconds).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 10,
                  children: [
                    for (final (index, word) in words.indexed)
                      Text(
                            word,
                            style: context.typo.header.copyWith(
                              fontSize: 36,
                              color: AppColors.blue,
                            ),
                          )
                          .animate(delay: (200 * (index + 1)).ms)
                          .fadeIn(duration: 800.ms)
                          .slideX(begin: -0.3, end: 0),
                  ],
                ),
              ),
              SvgPicture.asset('assets/icons/telescope.svg', height: 70),
            ],
          ),
        ],
      ),
    );
  }
}

/// web Section2~7 의 공통 모양: (섹션 이름) + 제목 줄 + 부제 줄 + (부가 요소).
class _MessageSection extends StatelessWidget {
  const _MessageSection({
    required this.background,
    required this.titles,
    this.subtitles = const [],
    this.sectionName,
    this.trailing,
  });

  final Color background;
  final List<String> titles;
  final List<String> subtitles;
  final String? sectionName;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionName != null) ...[
            Text(
                  sectionName!,
                  style: context.typo.bodyBold.copyWith(color: AppColors.blue),
                )
                .animate(delay: 200.ms)
                .fadeIn(duration: 800.ms)
                .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
          ],
          for (final title in titles)
            Text(title, style: context.typo.header.copyWith(fontSize: 28)),
          const SizedBox(height: 16),
          for (final subtitle in subtitles)
            Text(
              subtitle,
              style: context.typo.bodyRegular.copyWith(color: AppColors.gray3),
            ),
          if (trailing != null) ...[const SizedBox(height: 32), trailing!],
        ],
      ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.15, end: 0),
    );
  }
}

/// web `LabelsAnimation.tsx` 의 예시 제목 라벨.
class _LabelsAnimation extends StatelessWidget {
  const _LabelsAnimation();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titles = [
      l10n.intro_exampleTitle1,
      l10n.intro_exampleTitle2,
      l10n.intro_exampleTitle3,
      l10n.intro_exampleTitle4,
      l10n.intro_exampleTitle5,
      l10n.intro_exampleTitle6,
    ];
    const colors = [
      AppColors.blue,
      Color(0xFF5A9CFF),
      Color(0xFF7FB2FF),
      AppColors.skyblue,
      Color(0xFFB7A5FF),
      AppColors.deepblue8,
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (index, title) in titles.indexed)
          Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: context.typo.labelBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              )
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }
}

/// web Section6 `SearchBar.tsx`: 3초마다 위로 넘어가는 예시 검색어.
class _SearchTicker extends StatefulWidget {
  const _SearchTicker();

  @override
  State<_SearchTicker> createState() => _SearchTickerState();
}

class _SearchTickerState extends State<_SearchTicker> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => setState(() => _index++),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final examples = [
      l10n.intro_searchExample1,
      l10n.intro_searchExample2,
      l10n.intro_searchExample3,
      l10n.intro_searchExample4,
      l10n.intro_searchExample5,
    ];
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.skyblue),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                child: Align(
                  key: ValueKey(_index),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    examples[_index % examples.length],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.typo.body,
                  ),
                ),
              ),
            ),
          ),
          SvgPicture.asset('assets/icons/ver3/search.svg'),
        ],
      ),
    );
  }
}

/// web intro `Footer.tsx`: 비로그인이면 시작하기(로그인), 둘러보기(홈), 개인정보 처리방침.
class _Footer extends ConsumerWidget {
  const _Footer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final loggedOut = ref.watch(currentUserIdProvider) == null;
    final labelStyle = context.typo.labelSmall.copyWith(color: AppColors.gray);
    return Container(
      color: AppColors.bggray,
      padding: EdgeInsets.fromLTRB(
        24,
        40,
        24,
        40 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (loggedOut) ...[
            FilledButton(
              onPressed: () => context.push(AppRoutes.login),
              child: Text(l10n.common_start),
            ),
            const SizedBox(height: 8),
          ],
          OutlinedButton(
            onPressed: () => context.go(AppRoutes.home),
            child: Text(l10n.intro_tour),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => openExternalUrl(IntroScreen.privacyUrl),
            child: Text(l10n.intro_privacy, style: labelStyle),
          ),
          Text('에잇(Eight)', style: labelStyle),
          Text('Makers : 에잇(Eight, listywave8@gmail.com)', style: labelStyle),
          Text('Copyright ©Listywave - All rights reserved', style: labelStyle),
        ],
      ),
    );
  }
}
