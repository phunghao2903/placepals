import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum AiProgressStepVisualState {
  done,
  loading,
  pending,
}

class AiProgressStepTile extends StatelessWidget {
  final String label;
  final AiProgressStepVisualState visualState;

  const AiProgressStepTile({
    super.key,
    required this.label,
    required this.visualState,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _StepIndicator(visualState: visualState),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.heading5.copyWith(
              fontSize: 16,
              color: switch (visualState) {
                AiProgressStepVisualState.done => const Color(0xFF8E8787),
                AiProgressStepVisualState.loading => AppColors.textPrimary,
                AiProgressStepVisualState.pending => const Color(0xFFA69E9D),
              },
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final AiProgressStepVisualState visualState;

  const _StepIndicator({
    required this.visualState,
  });

  @override
  Widget build(BuildContext context) {
    switch (visualState) {
      case AiProgressStepVisualState.done:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0x73FF6B5A),
              width: 2,
            ),
          ),
          child: const Center(
            child: SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFFF6B5A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      case AiProgressStepVisualState.loading:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: Color(0xFFFFDED9),
          ),
        );
      case AiProgressStepVisualState.pending:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFBEB6), width: 2),
          ),
        );
    }
  }
}
