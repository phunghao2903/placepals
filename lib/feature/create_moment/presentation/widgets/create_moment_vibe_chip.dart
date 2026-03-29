import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'create_moment_icon_resolver.dart';

class CreateMomentVibeChip extends StatelessWidget {
  final String label;
  final String iconKey;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateMomentVibeChip({
    super.key,
    required this.label,
    required this.iconKey,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? SemanticTextColors.onBrand
        : AppColors.primary;
    final background = isSelected
        ? AppColors.primary
        : AppSemanticColors.secondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                resolveCreateMomentIcon(iconKey),
                color: foreground,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.body2.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
