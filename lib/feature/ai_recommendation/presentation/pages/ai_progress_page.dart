import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_progress_step_tile.dart';
import '../widgets/ai_screen_header.dart';
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
    _timer = Timer.periodic(const Duration(milliseconds: 850), (timer) {
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
      backgroundColor: const Color(0xFFFFFBFA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: <Widget>[
                    AiScreenHeader(
                      title: feed.askTitle,
                      onBack: () => Navigator.of(context).pop(),
                      reserveTrailingSpace: true,
                      padding: const EdgeInsets.fromLTRB(2, 6, 2, 8),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12FF6B5A),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0x1FFF6B5A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              state.prompt,
                              style: AppTextStyles.heading5.copyWith(
                                fontSize: 18,
                                height: 1.25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 44),
                    const _ProgressOrb(),
                    const SizedBox(height: 34),
                    Text(
                      feed.progressTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 30,
                        height: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feed.progressSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body1.copyWith(
                        fontSize: 16,
                        color: const Color(0xFFB0A4A3),
                      ),
                    ),
                    const SizedBox(height: 44),
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
                    const SizedBox(height: 42),
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
                          style: AppTextStyles.heading5.copyWith(
                            color: isDone
                                ? Colors.white
                                : const Color(0xFF9C9392),
                            fontSize: 18,
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
        width: 148,
        height: 148,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 108,
              height: 108,
              decoration: const BoxDecoration(
                color: Color(0x1FFF6B5A),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFF9287), Color(0xFFFF6B5A)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const Positioned(
              top: 18,
              right: 24,
              child: Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              top: 60,
              right: 4,
              child: Icon(
                Icons.star_border_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              left: 14,
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
