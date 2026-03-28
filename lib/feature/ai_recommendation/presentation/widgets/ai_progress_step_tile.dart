import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum AiProgressStepVisualState { done, loading, pending }

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
        const SizedBox(width: 18),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.heading5.copyWith(
              fontSize: 18,
              color: switch (visualState) {
                AiProgressStepVisualState.done => const Color(0xFF9C9493),
                AiProgressStepVisualState.loading => AppColors.textPrimary,
                AiProgressStepVisualState.pending => const Color(0xFFBDB5B4),
              },
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final AiProgressStepVisualState visualState;

  const _StepIndicator({required this.visualState});

  @override
  Widget build(BuildContext context) {
    switch (visualState) {
      case AiProgressStepVisualState.done:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFCFF1D8),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 18,
            color: Color(0xFF22C55E),
          ),
        );
      case AiProgressStepVisualState.loading:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: Color(0xFFE6DCDC),
          ),
        );
      case AiProgressStepVisualState.pending:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE6DCDC), width: 2),
          ),
        );
    }
  }
}
