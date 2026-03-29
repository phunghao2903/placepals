import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../widgets/auth_logo.dart';
import 'auth_gate_page.dart';
import 'whats_new_page.dart';

class SplashPage extends StatefulWidget {
  final bool showWhatsNewOnComplete;

  const SplashPage({
    super.key,
    this.showWhatsNewOnComplete = true,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const double _designWidth = 394;
  static const double _designHeight = 852;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => widget.showWhatsNewOnComplete
              ? const WhatsNewPage()
              : const AuthGatePage(),
        ),
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
          final double scale = math.min(
            constraints.maxWidth / _designWidth,
            constraints.maxHeight / _designHeight,
          );
          final double fittedWidth = _designWidth * scale;
          final double fittedHeight = _designHeight * scale;

          return Center(
            child: SizedBox(
              width: fittedWidth,
              height: fittedHeight,
              child: Transform.scale(
                alignment: Alignment.topLeft,
                scale: scale,
                child: const SizedBox(
                  width: _designWidth,
                  height: _designHeight,
                  child: _SplashArtboard(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SplashArtboard extends StatelessWidget {
  const _SplashArtboard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned(
          left: 37,
          top: 258,
          child: _SplashGlow(),
        ),
        const Positioned(
          left: 343,
          top: 96,
          child: _SparkDots(),
        ),
        const Positioned(
          left: 77,
          top: 281,
          child: _SplashBrandBlock(),
        ),
        const Positioned(
          left: 72,
          top: 655,
          child: _SplashIllustration(),
        ),
      ],
    );
  }
}

class _SplashGlow extends StatelessWidget {
  const _SplashGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: 320,
        height: 320,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                Colors.white.withValues(alpha: 0.14),
                Colors.white.withValues(alpha: 0.06),
                Colors.transparent,
              ],
              stops: <double>[0.0, 0.52, 1.0],
            ),
          ),
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
      width: 232,
      height: 280,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const Positioned(
            top: 0,
            child: AuthLogo(
              size: 104,
              showTitle: false,
              backgroundColor: Color(0xFFF4F1F0),
              iconColor: AppColors.primary,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 36,
                  offset: Offset(0, 25),
                ),
              ],
            ),
          ),
          Positioned(
            top: 160,
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
            top: 184,
            child: Text(
              'PlacePals',
              style: AppTextStyles.heading1.copyWith(
                fontSize: 38,
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
            top: 236,
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
            top: 224,
            left: -76,
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
      width: 250,
      height: 186,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
