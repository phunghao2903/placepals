import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? iconAsset = _assetForLabel(label);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
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
              if (iconAsset != null) ...<Widget>[
                ImageIcon(
                  AssetImage(iconAsset),
                  size: 18,
                  color: isSelected
                      ? ComponentColors.chipSelectedIcon
                      : ComponentColors.chipBrandIcon,
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
        ),
      ),
    );
  }

  String? _assetForLabel(String value) {
    switch (value.toLowerCase()) {
      case 'coffee':
        return 'assets/icons/coffe.png';
      case 'outdoors':
        return 'assets/icons/uotdoors.png';
      case 'bar':
        return 'assets/icons/bar.png';
      default:
        return null;
    }
  }
}
