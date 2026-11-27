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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        key: const Key('intro.scroll'),
        padding: EdgeInsets.zero,
        children: const [
          _HeroSection(),
          _WaveSection(),
          _RecordSection(),
          _HistorySection(),
          _SearchSection(),
          _SurfSection(),
          _ShareSection(),
          _Footer(),
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

/// web intro 의 글자 (`styles/__font.css.ts`). 색은 web 전역 글자색 (`theme.css` black) 이다.
/// CSS line-height 처럼 남는 높이를 글자 위아래에 똑같이 나눈다.
const _introText = TextStyle(
  fontFamily: AppTypography.fontFamily,
  color: AppColors.black,
  leadingDistribution: TextLeadingDistribution.even,
);

/// 제목 `<h3>`: wrapper 의 `headlineLarge` (32px, line-height 40px) 를 물려받지만 web 전역 reset 이
/// margin/padding 만 지워서 브라우저 기본 h3 스타일 (font-size 1.17em, bold) 이 남는다.
/// 그래서 37.44/700 에 line-height 40 이다.
final _headlineLarge = _introText.copyWith(
  fontSize: 32 * 1.17,
  fontWeight: FontWeight.w700,
  height: 40 / (32 * 1.17),
);

/// `bodyRegular` (15/500, line-height 20) + 부제 색 #828282.
final _subTitle = _introText.copyWith(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  height: 20 / 15,
  letterSpacing: 0.2,
  color: const Color(0xFF828282),
);

/// Section5~7 `sectionNameWrapper` (22/600, letter-spacing 0.088). line-height 는 normal 이라 web 에서
/// 27 높이로 그려진다 (Flutter 기본 metrics 는 31).
final _sectionName = _introText.copyWith(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  height: 27 / 22,
  letterSpacing: 0.088,
);

/// web 의 끝없는 CSS animation 을 [count] 번 (한 방향이 1번) 돌리고 멈춘다. 끝없는 animation 은
/// 화면이 안정되지 않아 (pumpAndSettle·접근성 도구) 막는다. flutter_animate 의 `repeat(count:)` 는
/// 멈출 때를 Timer 로 재서, 섹션이 먼저 사라지면 Timer 가 남는다. 그래서 status 로 센다.
void _loop(AnimationController controller, int count) {
  var remaining = count - 1;
  void onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed &&
        status != AnimationStatus.dismissed) {
      return;
    }
    if (remaining-- <= 0) {
      controller.removeStatusListener(onStatus);
      return;
    }
    status == AnimationStatus.completed
        ? controller.reverse()
        : controller.forward();
  }

  controller.addStatusListener(onStatus);
}

/// [_loop] 횟수: 한 방향이 [half] 인 animation 을 약 2분 동안.
int _loopsFor(Duration half) =>
    (const Duration(minutes: 2).inMilliseconds / half.inMilliseconds).ceil();

/// web `MotionWrapper.tsx` 의 variants. framer-motion 은 화면 40% 가 보일 때 재생하고, 앱은 lazy
/// [ListView] 가 섹션을 build 할 때 재생한다.
enum _Motion { vertical, horizontal, reverseHorizontal, popUp }

extension on Widget {
  Widget motion(_Motion type, {double delay = 0}) {
    final (begin, end) = switch (type) {
      _Motion.vertical => (const Offset(0, 50), Offset.zero),
      _Motion.horizontal => (const Offset(-30, 0), Offset.zero),
      _Motion.reverseHorizontal => (const Offset(30, 0), Offset.zero),
      _Motion.popUp => (const Offset(30, 0), const Offset(0, 20)),
    };
    return animate(delay: Duration(milliseconds: (delay * 1000).round()))
        .fadeIn(duration: 800.ms, curve: Curves.easeOut)
        .move(begin: begin, end: end, duration: 800.ms, curve: Curves.easeOut);
  }
}

/// web Section3~7: 높이가 고정된 섹션. 내용이 높이를 넘으면 web 처럼 (overflow: visible) 아래
/// 섹션 쪽으로 그려진다. 다음 섹션이 나중에 그려지므로 불투명한 배경이면 가려진다.
class _FixedSection extends StatelessWidget {
  const _FixedSection({
    required this.height,
    required this.padding,
    required this.child,
    this.color,
    this.gradient,
  });

  final double height;
  final EdgeInsets padding;
  final Color? color;
  final Gradient? gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, gradient: gradient),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: padding.left,
              right: padding.right,
              top: padding.top,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

/// 세로로 [gap] 만큼 띄운 글자 줄 (web `display: flex; flex-direction: column; gap`).
class _Lines extends StatelessWidget {
  const _Lines({
    required this.lines,
    required this.style,
    required this.gap,
    this.align = CrossAxisAlignment.center,
  });

  final List<String> lines;
  final TextStyle style;
  final double gap;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final textAlign = switch (align) {
      CrossAxisAlignment.start => TextAlign.start,
      CrossAxisAlignment.end => TextAlign.end,
      _ => TextAlign.center,
    };
    return Column(
      crossAxisAlignment: align,
      children: [
        for (final (i, line) in lines.indexed) ...[
          if (i > 0) SizedBox(height: gap),
          Text(line, style: style, textAlign: textAlign),
        ],
      ],
    );
  }
}

/// web intro `Section3.tsx` (`Section3.css.ts`): 높이 752 흰 화면. 왼쪽 위 깜빡이는 빨간 점 "REC",
/// 가운데 제목·부제, 아래 리스트 작성 영상 (web mp4 → 15fps GIF) 과 흰 그라데이션.
class _RecordSection extends StatelessWidget {
  const _RecordSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return _FixedSection(
      height: 752,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(0, 71, 0, 77),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Container(
                      width: 13,
                      height: 13,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5454),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(onPlay: (c) => _loop(c, _loopsFor(500.ms)))
                    .fadeIn(duration: 500.ms, curve: Curves.easeInOut),
                const SizedBox(width: 7),
                Text(
                  'REC',
                  style: _introText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 24 / 16,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 55.5, 0, 46),
            child: Column(
              children: [
                _Lines(
                  lines: [l10n.intro_message3, l10n.intro_message4],
                  style: _headlineLarge,
                  gap: 5,
                ),
                const SizedBox(height: 17),
                _Lines(
                  lines: [l10n.intro_message5, l10n.intro_message6],
                  style: _subTitle,
                  gap: 7,
                ),
                const SizedBox(height: 59),
                // imageWrapper: 높이 400, 영상은 폭 100% (860x800), blurBox 는 아래 -20 에 174.
                SizedBox(
                  height: 400,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/intro/section3_video.gif',
                        width: width,
                        height: width * 800 / 860,
                        fit: BoxFit.fill,
                        excludeFromSemantics: true,
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: -20,
                        height: 174,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // web: 투명 -8.85% → 흰색 53.58%. 0 에서의 값으로 시작한다.
                              stops: [0, 0.5358],
                              colors: [Color(0x24FFFFFF), AppColors.white],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).motion(_Motion.vertical),
        ],
      ),
    );
  }
}

/// web intro `Section4.tsx` (`Section4.css.ts`): 높이 700, #E8F7FF. 가운데 제목·부제, 아래 순위 변화
/// 그래프 그림 (348x320, filter 그림자가 있어 PNG 로 바꿨다) 과 그 위에서 커졌다 작아지는 하트.
class _HistorySection extends StatelessWidget {
  const _HistorySection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FixedSection(
      height: 700,
      color: const Color(0xFFE8F7FF),
      padding: const EdgeInsets.fromLTRB(30, 70, 30, 77),
      child: Column(
        children: [
          _Lines(
            lines: [l10n.intro_message7, l10n.intro_message8],
            style: _headlineLarge,
            gap: 5,
          ),
          const SizedBox(height: 20),
          _Lines(
            lines: [
              l10n.intro_message9,
              l10n.intro_message10,
              l10n.intro_message11,
            ],
            style: _subTitle,
            gap: 7,
          ),
          const SizedBox(height: 50),
          // imageWrapper: margin-left 20 + 그림 348 이 내용 폭 330 보다 넓어 web 처럼 가운데에서 넘친다.
          SizedBox(
            height: 320,
            child: OverflowBox(
              maxWidth: 368,
              child: SizedBox(
                width: 368,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 20,
                      top: 0,
                      child: Image.asset(
                        'assets/images/intro/section4_hero.png',
                        width: 348,
                        height: 320,
                        excludeFromSemantics: true,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: -20,
                      child:
                          Image.asset(
                                'assets/icons/png/heart_3d.png',
                                width: 80,
                                height: 80,
                                excludeFromSemantics: true,
                              )
                              .animate(
                                onPlay: (c) => _loop(c, _loopsFor(1.seconds)),
                              )
                              .scaleXY(
                                begin: 1,
                                end: 1.3,
                                duration: 1.seconds,
                                curve: Curves.easeInOut,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ).motion(_Motion.vertical, delay: 0.2),
    );
  }
}

/// web intro `Section5.tsx` (`Section5.css.ts`): 높이 900 흰 화면. 왼쪽 정렬 "👀 발견해요", 돋보기가
/// 붙은 제목, 부제, 아래 좌우로 흐르는 예시 제목 라벨 6줄 ([_LabelsAnimation]).
class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // web `breakTitle`: 395px 미만에서만 message12 와 13 사이를 줄바꿈한다.
    final title1 = MediaQuery.sizeOf(context).width < 395
        ? '${l10n.intro_message12}\n${l10n.intro_message13}'
        : '${l10n.intro_message12} ${l10n.intro_message13}';
    return _FixedSection(
      height: 900,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(0, 147, 0, 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/png/eye_emoji.png',
                      width: 23,
                      height: 23,
                      semanticLabel: l10n.intro_eyeIcon,
                    ),
                    const SizedBox(width: 4),
                    Text(l10n.intro_message17, style: _sectionName),
                  ],
                ).motion(_Motion.horizontal, delay: 0.4),
                const SizedBox(height: 55),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text(title1, style: _headlineLarge)),
                        const SizedBox(width: 4),
                        Image.asset(
                          'assets/icons/png/magnifying_glass.png',
                          width: 30,
                          height: 34,
                          semanticLabel: l10n.intro_readingGlassesIcon,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(l10n.intro_message14, style: _headlineLarge),
                  ],
                ).motion(_Motion.horizontal, delay: 0.6),
                const SizedBox(height: 18),
                _Lines(
                  lines: [l10n.intro_message15, l10n.intro_message16],
                  style: _subTitle,
                  gap: 7,
                  align: CrossAxisAlignment.start,
                ).motion(_Motion.horizontal, delay: 0.8),
                const SizedBox(height: 50),
              ],
            ),
          ),
          const _LabelsAnimation(),
        ],
      ).motion(_Motion.vertical, delay: 0.2),
    );
  }
}

/// web `Label.css.ts` 의 배경색.
enum _LabelColor {
  blue1(Color(0xFF0047FF)),
  blue2(Color(0xFF0099FF)),
  blue3(Color(0xFF0900FF)),
  blue4(Color(0xFF5585FF)),
  skyblue(Color(0xFF00E9FF)),
  purple(Color(0xFF5C00FF));

  const _LabelColor(this.color);
  final Color color;
}

/// web `LabelsAnimation.tsx`: 높이 300 (넘치면 자름), 줄 간격 12 의 라벨 6줄. 줄마다 폭 (화면 폭) 의
/// -100% ↔ 0 사이를 정해진 주기로 왕복한다 (moveRight: -100% → 0 → -100%, moveLeft: 0 → -100% → 0).
class _LabelsAnimation extends StatelessWidget {
  const _LabelsAnimation();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = [
      l10n.intro_exampleTitle1,
      l10n.intro_exampleTitle2,
      l10n.intro_exampleTitle3,
      l10n.intro_exampleTitle4,
      l10n.intro_exampleTitle5,
      l10n.intro_exampleTitle6,
      l10n.intro_exampleTitle7,
      l10n.intro_exampleTitle8,
      l10n.intro_exampleTitle9,
      l10n.intro_exampleTitle10,
      l10n.intro_exampleTitle11,
      l10n.intro_exampleTitle12,
      l10n.intro_exampleTitle13,
      l10n.intro_exampleTitle14,
      l10n.intro_exampleTitle15,
      l10n.intro_exampleTitle16,
      l10n.intro_exampleTitle17,
      l10n.intro_exampleTitle18,
      l10n.intro_exampleTitle19,
      l10n.intro_exampleTitle20,
      l10n.intro_exampleTitle21,
      l10n.intro_exampleTitle22,
      l10n.intro_exampleTitle23,
      l10n.intro_exampleTitle24,
    ];
    const left = _Arrow(
      'assets/images/intro/arrow_left.svg',
      Color(0xFF7FA3FF),
    );
    const right = _Arrow(
      'assets/images/intro/arrow_right.svg',
      Color(0xFF999FF8),
    );
    Widget label(_LabelColor color, String text) => _Label(color, text);
    return SizedBox(
      height: 300,
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            return Column(
              children: [
                _LabelLine(width: w, toRight: true, seconds: 20, [
                  label(_LabelColor.blue1, t[0]),
                  label(_LabelColor.blue2, t[1]),
                  label(_LabelColor.blue3, t[2]),
                  label(_LabelColor.skyblue, t[3]),
                ]),
                const SizedBox(height: 12),
                _LabelLine(width: w, toRight: false, seconds: 30, [
                  label(_LabelColor.purple, t[4]),
                  label(_LabelColor.blue4, t[5]),
                  label(_LabelColor.blue1, t[6]),
                  left,
                  label(_LabelColor.purple, t[7]),
                ]),
                const SizedBox(height: 12),
                _LabelLine(width: w, toRight: true, seconds: 20, [
                  label(_LabelColor.blue2, t[8]),
                  label(_LabelColor.blue3, t[9]),
                  label(_LabelColor.skyblue, t[10]),
                  label(_LabelColor.blue1, t[11]),
                ]),
                const SizedBox(height: 12),
                _LabelLine(width: w, toRight: false, seconds: 40, [
                  label(_LabelColor.purple, t[12]),
                  label(_LabelColor.blue3, t[13]),
                  label(_LabelColor.blue4, t[14]),
                  label(_LabelColor.blue3, t[15]),
                ]),
                const SizedBox(height: 12),
                _LabelLine(width: w, toRight: true, seconds: 35, [
                  label(_LabelColor.skyblue, t[16]),
                  label(_LabelColor.blue1, t[17]),
                  label(_LabelColor.purple, t[18]),
                  left,
                  label(_LabelColor.blue2, t[19]),
                ]),
                const SizedBox(height: 12),
                _LabelLine(width: w, toRight: true, seconds: 60, [
                  label(_LabelColor.blue4, t[20]),
                  right,
                  label(_LabelColor.blue2, t[21]),
                  label(_LabelColor.blue1, t[22]),
                  label(_LabelColor.blue3, t[23]),
                ]),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 라벨 한 줄: 화면 밖으로 넘치는 라벨 (gap 10) 을 좌우로 움직인다. 화살표 라벨 (테두리 2) 이 있는
/// 줄은 높이가 40, 아니면 36 이고 같은 줄의 라벨은 그 높이로 늘어난다 (flex stretch).
class _LabelLine extends StatelessWidget {
  const _LabelLine(
    this.children, {
    required this.width,
    required this.toRight,
    required this.seconds,
  });

  final List<Widget> children;
  final double width;
  final bool toRight;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    final half = Duration(milliseconds: seconds * 500);
    return SizedBox(
      height: children.any((c) => c is _Arrow) ? 40 : 36,
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        maxWidth: double.infinity,
        child:
            Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (i, child) in children.indexed) ...[
                      if (i > 0) const SizedBox(width: 10),
                      child,
                    ],
                  ],
                )
                .animate(onPlay: (c) => _loop(c, _loopsFor(half)))
                .moveX(
                  begin: toRight ? -width : 0,
                  end: toRight ? 0 : -width,
                  duration: half,
                  curve: Curves.linear,
                ),
      ),
    );
  }
}

/// web `Label.tsx`: labelMedium (14/500, line-height 24) 흰 대문자, padding 6 24, 둥근 pill.
class _Label extends StatelessWidget {
  const _Label(this.color, this.text);

  final _LabelColor color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text.toUpperCase(),
        style: _introText.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 24 / 14,
          letterSpacing: 0.4,
          color: AppColors.white,
        ),
      ),
    );
  }
}

/// web `LabelsAnimation.tsx` 의 ArrowLeft/ArrowRight: 흰 라벨 + 색 테두리 2 + 135x16 화살표.
class _Arrow extends StatelessWidget {
  const _Arrow(this.asset, this.border);

  final String asset;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: border, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SvgPicture.asset(asset, width: 135, height: 16),
    );
  }
}

/// web intro `Section6.tsx` (`Section6.css.ts`): 높이 750 흰 화면. 오른쪽 정렬 제목·부제, 예시 검색어가
/// 3초마다 위로 넘어가는 검색창, 아래 위아래로 출렁이며 흐르는 리스트 카드 ([_ListWave]).
class _SurfSection extends StatelessWidget {
  const _SurfSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FixedSection(
      height: 750,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(0, 81, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  l10n.intro_message21,
                  style: _headlineLarge,
                  textAlign: TextAlign.end,
                ).motion(_Motion.reverseHorizontal, delay: 0.5),
                const SizedBox(height: 18),
                _Lines(
                  lines: [
                    l10n.intro_message18,
                    l10n.intro_message19,
                    l10n.intro_message20,
                  ],
                  style: _subTitle,
                  gap: 7,
                  align: CrossAxisAlignment.end,
                ).motion(_Motion.reverseHorizontal, delay: 0.7),
                const SizedBox(height: 32),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 80),
            child: Align(
              alignment: Alignment.centerRight,
              child: _SearchTicker(),
            ),
          ),
          const _ListWave(),
        ],
      ).motion(_Motion.vertical, delay: 0.3),
    );
  }
}

/// web Section6 `SearchBar.tsx`: 330x37 회색 (#EFEFF0) 둥근 창. swiper 가 3초마다 예시 검색어 10개를
/// 위로 넘긴다 (loop).
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
      l10n.intro_searchExample6,
      l10n.intro_searchExample7,
      l10n.intro_searchExample8,
      l10n.intro_searchExample9,
      l10n.intro_searchExample10,
    ];
    final current = ValueKey(_index);
    return Container(
      width: 330,
      height: 37,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFF0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                // 들어오는 글자는 아래에서, 나가는 글자는 위로 (swiper vertical).
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween(
                    begin: Offset(0, child.key == current ? 1 : -1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                child: Align(
                  key: current,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    examples[_index % examples.length],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _introText.copyWith(
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.08,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/images/intro/search.svg',
            width: 16,
            height: 17,
          ),
        ],
      ),
    );
  }
}

/// web Section6 `ListWave.tsx`: 높이 268 (padding 20, 넘치면 자름). 카드 7장 (gap 30) 이 20초 주기로
/// 화면 폭의 -135% ↔ 0 을 왕복하고, 카드마다 0.3초씩 늦게 2초 주기로 30 만큼 위아래로 움직인다.
class _ListWave extends StatelessWidget {
  const _ListWave();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cards = [
      (
        'culture',
        [
          l10n.intro_exampleItem1_1,
          l10n.intro_exampleItem1_2,
          l10n.intro_exampleItem1_3,
        ],
        l10n.intro_exampleItem1_alt,
      ),
      (
        'life',
        [
          l10n.intro_exampleItem2_1,
          l10n.intro_exampleItem2_2,
          l10n.intro_exampleItem2_3,
        ],
        l10n.intro_exampleItem2_alt,
      ),
      (
        'place',
        [
          l10n.intro_exampleItem3_1,
          l10n.intro_exampleItem3_2,
          l10n.intro_exampleItem3_3,
        ],
        l10n.intro_exampleItem3_alt,
      ),
      (
        'music',
        [
          l10n.intro_exampleItem4_1,
          l10n.intro_exampleItem4_2,
          l10n.intro_exampleItem4_3,
        ],
        l10n.intro_exampleItem4_alt,
      ),
      (
        'play',
        [
          l10n.intro_exampleItem5_1,
          l10n.intro_exampleItem5_2,
          l10n.intro_exampleItem5_3,
        ],
        l10n.intro_exampleItem5_alt,
      ),
      (
        'book',
        [
          l10n.intro_exampleItem6_1,
          l10n.intro_exampleItem6_2,
          l10n.intro_exampleItem6_3,
        ],
        l10n.intro_exampleItem6_alt,
      ),
      (
        'plant',
        [
          l10n.intro_exampleItem7_1,
          l10n.intro_exampleItem7_2,
          l10n.intro_exampleItem7_3,
        ],
        l10n.intro_exampleItem7_alt,
      ),
    ];
    final itemStyle = _introText.copyWith(
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.048,
      color: AppColors.white,
    );
    const half = Duration(seconds: 10);
    return SizedBox(
      height: 268,
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: OverflowBox(
              alignment: Alignment.topLeft,
              maxWidth: double.infinity,
              child:
                  Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final (i, (category, items, alt))
                              in cards.indexed) ...[
                            if (i > 0) const SizedBox(width: 30),
                            _ListCard(
                                  image:
                                      'assets/images/intro/section6_image${i + 1}.png',
                                  icon:
                                      'assets/images/intro/category_$category.png',
                                  iconLabel: alt,
                                  items: items,
                                  style: itemStyle,
                                )
                                .animate(
                                  delay: (300 * i).ms,
                                  onPlay: (c) => _loop(c, _loopsFor(1.seconds)),
                                )
                                .moveY(
                                  begin: 0,
                                  end: 30,
                                  duration: 1.seconds,
                                  curve: Curves.ease,
                                ),
                          ],
                        ],
                      )
                      .animate(onPlay: (c) => _loop(c, _loopsFor(half)))
                      .moveX(
                        begin: -1.35 * constraints.maxWidth,
                        end: 0,
                        duration: half,
                        curve: Curves.linear,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

/// web `ListWave.css.ts` listWrapper: 최소 폭 109, 높이 150, padding 8 10, 배경 그림 contain (왼쪽 위),
/// 흰 bodySmall 순위 3줄 (gap 8.15), 오른쪽 위 -20 에 카테고리 그림 60.
class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.image,
    required this.icon,
    required this.iconLabel,
    required this.items,
    required this.style,
  });

  final String image;
  final String icon;
  final String iconLabel;
  final List<String> items;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 109),
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.contain,
              alignment: Alignment.topLeft,
            ),
          ),
          child: _Lines(
            lines: items,
            style: style,
            gap: 8.15,
            align: CrossAxisAlignment.start,
          ),
        ),
        Positioned(
          right: -20,
          top: -20,
          child: Image.asset(
            icon,
            width: 60,
            height: 60,
            semanticLabel: iconLabel,
          ),
        ),
      ],
    );
  }
}

/// web intro `Section7.tsx` (`Section7.css.ts`): 높이 827, 아래 rgba(193,232,254,.35) → 위
/// rgba(235,244,255,.1) 그라데이션. 가운데 "🔗 공유해요", 제목·부제, 핸드폰 그림 (255x518) 과 옆에서
/// 튀어나오는 "listywave.com/user/1" pill. 그림은 섹션보다 길어 Footer 위로 넘친다 (web 과 같음).
class _ShareSection extends StatelessWidget {
  const _ShareSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // web `wordBreakContainer`: 415px 이하에서는 두 줄을 세로로 (gap 4), 넘으면 가로로 (gap 8).
    final stacked = MediaQuery.sizeOf(context).width <= 415;
    Widget pair(String a, String b, TextStyle style) => stacked
        ? _Lines(lines: [a, b], style: style, gap: 4)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(a, style: style),
              const SizedBox(width: 8),
              Text(b, style: style),
            ],
          );
    return _FixedSection(
      height: 827,
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0x59C1E8FE), Color(0x1AEBF4FF)],
      ),
      padding: const EdgeInsets.fromLTRB(30, 90, 30, 50),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/png/linkIcon_3d.png',
                width: 20,
                height: 20,
                excludeFromSemantics: true,
              ),
              const SizedBox(width: 4),
              Text(l10n.intro_message22, style: _sectionName),
            ],
          ),
          const SizedBox(height: 10),
          pair(l10n.intro_message23, l10n.intro_message24, _headlineLarge),
          const SizedBox(height: 20),
          Text(
            l10n.intro_message25,
            style: _subTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 7),
          pair(l10n.intro_message26, l10n.intro_message27, _subTitle),
          const SizedBox(height: 50),
          SizedBox(
            width: 255,
            height: 518,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/intro/section7_phone.png',
                  width: 255,
                  height: 518,
                  semanticLabel: l10n.intro_cellphoneImage,
                ),
                Positioned(
                  left: -40,
                  top: 150,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Text(
                      'listywave.com/user/1',
                      style: _introText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ).motion(_Motion.popUp, delay: 0.6),
                ),
              ],
            ),
          ),
        ],
      ).motion(_Motion.vertical, delay: 0.2),
    );
  }
}

/// web intro `Footer.tsx` (`Footer.css.ts`): 하늘색 그라데이션, padding 6 17 90. 가운데 389 높이에
/// 182 폭 pill 버튼 (시작하기 web `__theme` blue #0047FF, 둘러보기 #82C3FF, 18/600 흰 글자), 아래 bodySmall gray7 정보.
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
                      style: pill(const Color(0xFF0047FF)),
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
