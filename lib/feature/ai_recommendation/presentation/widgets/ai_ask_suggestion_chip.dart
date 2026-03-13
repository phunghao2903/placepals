import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AiAskSuggestionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AiAskSuggestionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : const Color(0xFFF9CEC8),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            label,
            style: AppTextStyles.body1.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
