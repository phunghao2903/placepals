import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class MapCategoryChip extends StatelessWidget {
  final String label;
  final String? iconAsset;
  final bool isSelected;
  final VoidCallback? onTap;

  const MapCategoryChip({
    super.key,
    required this.label,
    this.iconAsset,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isSelected
        ? ComponentColors.chipSelectedBackground
        : ComponentColors.chipBrandBackground;
    final foreground = isSelected
        ? ComponentColors.chipSelectedText
        : ComponentColors.chipBrandText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 24 : 17,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (iconAsset != null) ...<Widget>[
                ImageIcon(
                  AssetImage(iconAsset!),
                  size: 18,
                  color: foreground,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppTextStyles.heading3.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
