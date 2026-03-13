import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class MapFriendFilter extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const MapFriendFilter({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: isSelected
                ? AppSemanticColors.primary
                : AppSemanticColors.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.body2.copyWith(
              color: isSelected
                  ? SemanticTextColors.onBrand
                  : AppSemanticColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
