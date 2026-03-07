import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final IconData? icon = _iconForLabel(label);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 24 : 13,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? ComponentColors.chipSelectedBackground
            : ComponentColors.chipBrandBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!isSelected && icon != null) ...<Widget>[
            Icon(
              icon,
              size: 16,
              color: ComponentColors.chipBrandIcon,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.heading3.copyWith(
              color: isSelected
                  ? ComponentColors.chipSelectedText
                  : ComponentColors.chipBrandText,
            ),
          ),
        ],
      ),
    );
  }

  IconData? _iconForLabel(String value) {
    switch (value.toLowerCase()) {
      case 'coffee':
        return Icons.local_cafe_rounded;
      case 'outdoors':
        return Icons.park_rounded;
      case 'bar':
        return Icons.sports_bar_rounded;
      default:
        return null;
    }
  }
}
