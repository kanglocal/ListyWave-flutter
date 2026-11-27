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
          const _WaveSection(),
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

/// web intro `Section1.tsx` (`Section1.css.ts`): 높이 842 의 노란(#FFD600) 화면. 가운데 로고,
/// 120 아래 파도 그림(371x376) 위에 흰 60/700 "What's In Your List" 와 망원경, 아래에 튀는 ⌄⌄.
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static const _yellow = Color(0xFFFFD600);

  /// web titleWrapper(높이 690)는 파도 그림(376) 기준으로 세로 가운데라 (690 - 376) / 2 만큼 위다.
  static const _titleOffset = (690 - 376) / 2;

  /// web `__theme.css.ts` gray7 (글자 그림자).
  static const _shadow = Color(0xFFAFB1B6);

  @override
  Widget build(BuildContext context) {
    const words = ["What's", 'In', 'Your', 'List'];
    final top = MediaQuery.paddingOf(context).top;
    final headline = context.typo.header.copyWith(
      fontSize: 60,
      height: 1,
      letterSpacing: 0,
      color: AppColors.white,
      shadows: const [
        Shadow(color: _shadow, offset: Offset(1, 1), blurRadius: 7),
      ],
    );
    return Container(
      height: 842 + top,
      color: _yellow,
      child: Stack(
        children: [
          Column(
            children: [
              // logoWrapper: padding 38 0 24.
              Padding(
                padding: EdgeInsets.fromLTRB(0, top + 38, 0, 24),
                child: Semantics(
                  button: true,
                  label: AppLocalizations.of(context).common_goHome,
                  child: GestureDetector(
                    onTap: () => context.go(AppRoutes.home),
                    child: Image.asset(
                      'assets/icons/png/logo.png',
                      width: 128,
                      height: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              SizedBox(
                width: 371,
                height: 376,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/images/wave_surf.png',
                      width: 371,
                      height: 376,
                    ),
                    // textWrapper: titleWrapper 기준 left 37, top 86 (가로 1.07 배).
                    Positioned(
                      left: 37 - (390 - 371) / 2,
                      top: 86 - _titleOffset,
                      child: Transform(
                        transform: Matrix4.diagonal3Values(1.07, 1, 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final (i, word) in words.indexed)
                              Text(word, style: headline)
                                  .animate(delay: (200 * (i + 1)).ms)
                                  .fadeIn(duration: 800.ms)
                                  .slideX(begin: -0.3, end: 0),
                          ],
                        ),
                      ),
                    ),
                    // telescopeWrapper: left 210, top 35.
                    Positioned(
                      left: 210 - (390 - 371) / 2,
                      top: 35 - _titleOffset,
                      child: Image.asset(
                        'assets/icons/png/telescope.png',
                        width: 70,
                        height: 86,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 1.seconds).slideY(begin: 0.05, end: 0),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child:
                  SvgPicture.asset(
                        'assets/icons/chevron_down_double.svg',
                        width: 30,
                        height: 33,
                      )
                      // web 은 1초 bounce 를 끝없이 돈다. 끝없는 animation 은 화면이 안정되지
                      // 않아 (pumpAndSettle·접근성 도구) 5번만 튀고 멈춘다.
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true, count: 10),
                      )
                      .moveY(begin: 0, end: 10, duration: 500.ms),
            ),
          ),
        ],
      ),
    );
  }
}

/// web intro `Section2.tsx` (`Section2.css.ts`): 높이 658, #42BAFF → 투명 그라데이션.
/// 위 136 에서 파도 그림(430x510)과 테이프 그림, 그 위에 흰 22/600 문구와 32/800 "LISTY WAVE".
class _WaveSection extends StatelessWidget {
  const _WaveSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final description = context.typo.header.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 28 / 22,
      letterSpacing: 0.088,
      color: AppColors.white,
    );
    return Container(
      height: 658,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 42),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1535, 0.7644],
          colors: [Color(0xFF42BAFF), Color(0x0042BAFF)],
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: 136,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/wave_image.png',
                width: 430,
                height: 510,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            // tapeImageWrapper: 높이 170, 아래 50 (wrapper 높이 500 + padding 136 기준).
            Positioned(
              left: 0,
              right: 0,
              top: 136 + 500 - 50 - 170,
              height: 170,
              child: Transform.translate(
                offset: const Offset(-20, 0),
                child: Image.asset('assets/images/new_list.png'),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 136,
              child:
                  Column(
                        children: [
                          Text(l10n.intro_message1, style: description),
                          Text(l10n.intro_message2, style: description),
                          const SizedBox(height: 36),
                          Text(
                            'LISTY WAVE',
                            style: context.typo.header.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: 0.2, end: 0),
            ),
          ],
        ),
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

/// web intro `Footer.tsx` (`Footer.css.ts`): 하늘색 그라데이션, padding 6 17 90. 가운데 389 높이에
/// 182 폭 pill 버튼 (시작하기 blue, 둘러보기 #82C3FF, 18/600 흰 글자), 아래 bodySmall gray7 정보.
class _Footer extends ConsumerWidget {
  const _Footer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final loggedOut = ref.watch(currentUserIdProvider) == null;
    final labelStyle = context.typo.labelSmall.copyWith(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.048,
      color: _HeroSection._shadow,
    );
    ButtonStyle pill(Color color) => FilledButton.styleFrom(
      backgroundColor: color,
      foregroundColor: AppColors.white,
      fixedSize: const Size(182, 50),
      shape: const StadiumBorder(),
      textStyle: context.typo.subtitle.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
    );
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x59C1E8FE), Color(0x1AEBF4FF)],
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        17,
        6,
        17,
        90 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 389,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (loggedOut) ...[
                    FilledButton(
                      onPressed: () => context.push(AppRoutes.login),
                      style: pill(AppColors.blue),
                      child: Text(l10n.common_start),
                    ),
                    const SizedBox(height: 16),
                  ],
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.home),
                    style: pill(const Color(0xFF82C3FF)),
                    child: Text(l10n.intro_tour),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => openExternalUrl(IntroScreen.privacyUrl),
            child: Text(l10n.intro_privacy, style: labelStyle),
          ),
          const SizedBox(height: 16),
          Text('에잇(Eight)', style: labelStyle),
          const SizedBox(height: 16),
          Text('Makers : 에잇(Eight, listywave8@gmail.com)', style: labelStyle),
          const SizedBox(height: 16),
          Text('Copyright ©Listywave - All rights reserved', style: labelStyle),
        ],
      ),
    );
  }
}
