import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import 'signup_signin_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _cardsOffset;
  late final Animation<double> _cardsBlur;
  late final Animation<double> _cardsOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    final CurvedAnimation eased = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _cardsOffset = Tween<double>(begin: 18, end: 0).animate(eased);
    _cardsBlur = Tween<double>(begin: 4, end: 0).animate(eased);
    _cardsOpacity = Tween<double>(begin: 0.72, end: 1).animate(eased);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: _WelcomeSparkDots(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: 325.39,
                    child: Column(
                      children: <Widget>[
                        const AuthLogo(size: 80, showTitle: false),
                        const SizedBox(height: 24),
                        Text(
                          'PlacePals',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Share your favorite places',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'with friends',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 34),
                        _WelcomeStats(animation: _controller),
                        const SizedBox(height: 34),
                        AnimatedBuilder(
                          animation: _controller,
                          child: const Column(
                            children: <Widget>[
                              _WelcomeFeatureCard(
                                minHeight: 70,
                                color: Color(0xFFFF897B),
                                icon: Icons.location_on_outlined,
                                title: 'Discover new places',
                                subtitle: 'Find amazing spots near you',
                              ),
                              SizedBox(height: 20),
                              _WelcomeFeatureCard(
                                minHeight: 71,
                                color: Color(0xFFF59E0B),
                                icon: Icons.people_alt_outlined,
                                title: 'Connect with community',
                                subtitle: 'Share experiences together',
                              ),
                              SizedBox(height: 20),
                              _WelcomeFeatureCard(
                                minHeight: 82.17,
                                color: AppColors.primary,
                                icon: Icons.favorite_border_rounded,
                                title: 'Save memories',
                                subtitle: 'Keep your special places',
                              ),
                            ],
                          ),
                          builder: (BuildContext context, Widget? child) {
                            final double blur = _cardsBlur.value;
                            return Transform.translate(
                              offset: Offset(0, _cardsOffset.value),
                              child: Opacity(
                                opacity: _cardsOpacity.value,
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: blur,
                                    sigmaY: blur,
                                  ),
                                  child: child,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 325,
                    child: AuthPrimaryButton(
                      label: 'Sign up',
                      leadingIcon: Icons.person_add_alt_1_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                const SignupSigninPage(startInSignUp: true),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SignupSigninPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeSparkDots extends StatelessWidget {
  const _WelcomeSparkDots();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 18,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 6,
            child: _WelcomeSparkDot(color: Color(0xFFFFD45D)),
          ),
          Positioned(
            left: 6,
            top: 0,
            child: _WelcomeSparkDot(color: Color(0xFFFF897B)),
          ),
          Positioned(
            right: 0,
            top: 7,
            child: _WelcomeSparkDot(color: Color(0xFF68C9FF)),
          ),
          Positioned(
            left: 7,
            bottom: 0,
            child: _WelcomeSparkDot(color: Color(0xFFFFE9A6)),
          ),
        ],
      ),
    );
  }
}

class _WelcomeSparkDot extends StatelessWidget {
  final Color color;

  const _WelcomeSparkDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _WelcomeStats extends StatelessWidget {
  final Animation<double> animation;

  const _WelcomeStats({required this.animation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325.39,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 60.16,
            child: _AnimatedStatItem(
              animation: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 0.78, curve: Curves.easeOutCubic),
              ),
              beginValue: 0,
              endValue: 10,
              label: 'Users',
              formatter: _formatCounterK,
            ),
          ),
          const _StatDivider(),
          SizedBox(
            width: 60.16,
            child: _AnimatedStatItem(
              animation: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.24, 0.9, curve: Curves.easeOutCubic),
              ),
              beginValue: 0,
              endValue: 50,
              label: 'Places',
              formatter: _formatCounterK,
            ),
          ),
          const _StatDivider(),
          SizedBox(
            width: 50.1,
            child: _AnimatedStatItem(
              animation: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.46, 1.0, curve: Curves.easeOutCubic),
              ),
              beginValue: 3.8,
              endValue: 4.8,
              label: 'Rating',
              showStar: true,
              formatter: _formatCounterRating,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 31.5),
      color: const Color(0xFFF4F1F0),
    );
  }
}

class _AnimatedStatItem extends StatelessWidget {
  final Animation<double> animation;
  final double beginValue;
  final double endValue;
  final String label;
  final bool showStar;
  final String Function(double value) formatter;

  const _AnimatedStatItem({
    required this.animation,
    required this.beginValue,
    required this.endValue,
    required this.label,
    required this.formatter,
    this.showStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) {
        final double t = animation.value.clamp(0, 1);
        final double value = lerpDouble(beginValue, endValue, t) ?? endValue;
        final double slide = lerpDouble(18, 0, Curves.easeOutCubic.transform(t))!;
        final double scale = lerpDouble(0.78, 1.0, Curves.easeOutBack.transform(t))!;
        final double opacity = lerpDouble(0.18, 1.0, t)!;

        return Transform.translate(
          offset: Offset(0, slide),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    formatter(value),
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (showStar)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            label,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Text(
                      label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.1,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

String _formatCounterK(double value) => '${value.round()}K+';

String _formatCounterRating(double value) => value.toStringAsFixed(1);

class _WelcomeFeatureCard extends StatelessWidget {
  final double minHeight;
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const _WelcomeFeatureCard({
    required this.minHeight,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.39,
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.fromLTRB(17.09, 11, 12, 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

