import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class BottomNavItem extends StatelessWidget {
  final String iconAsset;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isActive
        ? AppSemanticColors.primary
        : SemanticIconColors.tertiary;
    final Color textColor = isActive
        ? AppSemanticColors.primary
        : SemanticTextColors.tertiary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          width: 60,
          height: 44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageIcon(AssetImage(iconAsset), size: 24, color: iconColor),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: textColor,
                  height: 1,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
