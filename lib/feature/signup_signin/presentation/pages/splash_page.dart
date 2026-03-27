import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../widgets/auth_logo.dart';
import 'whats_new_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const WhatsNewPage()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double frameWidth = math.min(constraints.maxWidth, 394);

          return Stack(
            children: <Widget>[
              Positioned(
                left: constraints.maxWidth * 0.5 - 192,
                top: constraints.maxHeight * 0.26,
                child: const _SplashGlow(),
              ),
              const Positioned(
                right: 54,
                top: 98,
                child: _SparkDots(),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: frameWidth,
                      height: constraints.maxHeight,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 201,
                            left: (frameWidth - 240) / 2,
                            child: const _SplashBrandBlock(),
                          ),
                          Positioned(
                            left: (frameWidth - 286) / 2,
                            bottom: 18,
                            child: const _SplashIllustration(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashGlow extends StatelessWidget {
  const _SplashGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: 384,
        height: 384,
        child: Stack(
          children: <Widget>[
            Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    blurRadius: 90,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 28,
              left: 0,
              child: Container(
                width: 384,
                height: 384,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.08),
                      blurRadius: 90,
                      spreadRadius: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashBrandBlock extends StatelessWidget {
  const _SplashBrandBlock();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 290,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const Positioned(
            top: 0,
            child: AuthLogo(
              size: 112,
              showTitle: false,
              backgroundColor: Color(0xFFF4F1F0),
              iconColor: AppColors.primary,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 50,
                  offset: Offset(0, 25),
                ),
              ],
            ),
          ),
          Positioned(
            top: 171,
            child: Container(
              width: 100,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            top: 196,
            child: Text(
              'PlacePals',
              style: AppTextStyles.heading1.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF4F1F0),
                height: 1,
                shadows: const <Shadow>[
                  Shadow(
                    color: Color(0xABFFC7C2),
                    offset: Offset(0, 4),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250,
            child: Text(
              'Share places, create memories',
              style: AppTextStyles.body1.copyWith(
                fontSize: 16,
                color: const Color(0xFFFFF0EF),
                height: 1,
              ),
            ),
          ),
          const Positioned(
            top: 236,
            left: -72,
            child: _SplashIndicator(),
          ),
        ],
      ),
    );
  }
}

class _SparkDots extends StatelessWidget {
  const _SparkDots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 6,
            child: _SparkDot(color: Color(0xFFFFEFC2)),
          ),
          Positioned(
            left: 6,
            top: 0,
            child: _SparkDot(color: Color(0xFFFDEFEA)),
          ),
          Positioned(
            right: 0,
            top: 7,
            child: _SparkDot(color: Color(0xFF8ED7FF)),
          ),
          Positioned(
            left: 7,
            bottom: 0,
            child: _SparkDot(color: Color(0xFFFFC9C1)),
          ),
        ],
      ),
    );
  }
}

class _SparkDot extends StatelessWidget {
  final Color color;

  const _SparkDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _SplashIndicator extends StatelessWidget {
  const _SplashIndicator();

  @override
  Widget build(BuildContext context) {
    final List<double> widths = <double>[4, 6, 9, 12, 15, 12, 9, 6, 4];

    return SizedBox(
      width: 384,
      height: 147,
      child: Align(
        alignment: const Alignment(0, 0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(widths.length, (int index) {
            final bool isCore = index >= 2 && index <= 6;
            return Container(
              width: widths[index],
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: BoxDecoration(
                color: isCore
                    ? const Color(0xFFF7A71B)
                    : const Color(0xFFF9B54A).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SplashIllustration extends StatelessWidget {
  const _SplashIllustration();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/group_30.png',
      width: 286,
      height: 212,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
