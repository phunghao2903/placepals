import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class PlaceIconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final List<BoxShadow> boxShadow;

  const PlaceIconCircleButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.textPrimary,
    this.size = 40,
    this.iconSize = 20,
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: boxShadow,
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
