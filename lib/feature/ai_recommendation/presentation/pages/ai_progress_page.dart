import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_progress_step_tile.dart';
import 'ai_results_page.dart';

class AiProgressPage extends StatefulWidget {
  const AiProgressPage({super.key});

  @override
  State<AiProgressPage> createState() => _AiProgressPageState();
}

class _AiProgressPageState extends State<AiProgressPage> {
  Timer? _timer;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (!mounted) return;
      setState(() {
        if (_currentStep < 4) {
          _currentStep += 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AiRecommendationBloc>().state;
    final feed = state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    final isDone = _currentStep >= feed.progressSteps.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4F3),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _RoundTopIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            feed.askTitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.heading4.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 44),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12FF6B5A),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCE8E5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              state.prompt,
                              style: AppTextStyles.heading4.copyWith(
                                fontSize: 22,
                                height: 1.25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const _ProgressOrb(),
                    const SizedBox(height: 30),
                    Text(
                      feed.progressTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 38,
                        height: 1.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      feed.progressSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body1.copyWith(
                        fontSize: 17,
                        color: const Color(0xFFAAA0A0),
                      ),
                    ),
                    const SizedBox(height: 48),
                    ...List<Widget>.generate(feed.progressSteps.length, (
                      index,
                    ) {
                      final visualState = index < _currentStep
                          ? AiProgressStepVisualState.done
                          : index == _currentStep && !isDone
                          ? AiProgressStepVisualState.loading
                          : AiProgressStepVisualState.pending;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == feed.progressSteps.length - 1
                              ? 0
                              : 24,
                        ),
                        child: AiProgressStepTile(
                          label: feed.progressSteps[index].label,
                          visualState: visualState,
                        ),
                      );
                    }),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isDone
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => BlocProvider.value(
                                      value: context
                                          .read<AiRecommendationBloc>(),
                                      child: const AiResultsPage(),
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDone
                              ? AppColors.primary
                              : const Color(0xFFE3D9D8),
                          foregroundColor: isDone
                              ? Colors.white
                              : const Color(0xFF9C9392),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(
                          isDone ? 'Explore' : 'Please wait...',
                          style: AppTextStyles.heading4.copyWith(
                            color: isDone
                                ? Colors.white
                                : const Color(0xFF9C9392),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoundTopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundTopIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}

class _ProgressOrb extends StatefulWidget {
  const _ProgressOrb();

  @override
  State<_ProgressOrb> createState() => _ProgressOrbState();
}

class _ProgressOrbState extends State<_ProgressOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = 1 + (_controller.value * 0.08);
        return Transform.scale(scale: pulse, child: child);
      },
      child: SizedBox(
        width: 160,
        height: 160,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                color: Color(0xFFF4D9D4),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFF9A66), Color(0xFFFF7A5F)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
            const Positioned(
              top: 18,
              right: 28,
              child: Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              top: 58,
              right: 6,
              child: Icon(
                Icons.star_border_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              left: 18,
              bottom: 34,
              child: Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
