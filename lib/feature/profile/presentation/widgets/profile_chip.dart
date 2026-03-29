import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ProfileChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final double height;
  final double radius;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? unselectedForegroundColor;
  final Color? unselectedBorderColor;
  final FontWeight selectedFontWeight;
  final FontWeight unselectedFontWeight;

  const ProfileChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 18),
    this.height = 38,
    this.radius = 20,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedForegroundColor,
    this.unselectedForegroundColor,
    this.unselectedBorderColor,
    this.selectedFontWeight = FontWeight.w600,
    this.unselectedFontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    final Color background = isSelected
        ? (selectedBackgroundColor ?? AppSemanticColors.primary)
        : (unselectedBackgroundColor ?? AppColors.surfaceSoft);
    final Color foreground = isSelected
        ? (selectedForegroundColor ?? SemanticTextColors.onBrand)
        : (unselectedForegroundColor ?? AppColors.textPrimary);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Ink(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isSelected
                  ? background
                  : (unselectedBorderColor ?? AppColors.border),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: foreground,
                fontSize: 12,
                fontWeight: isSelected
                    ? selectedFontWeight
                    : unselectedFontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
