import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AuthLogo extends StatelessWidget {
  final double size;
  final double titleSize;
  final bool showTitle;
  final Color titleColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color badgeColor;
  final IconData badgeIcon;
  final Color badgeIconColor;
  final List<BoxShadow>? boxShadow;

  const AuthLogo({
    super.key,
    this.size = 56,
    this.titleSize = 24,
    this.showTitle = true,
    this.titleColor = AppColors.textPrimary,
    this.backgroundColor = AppColors.primary,
    this.iconColor = Colors.white,
    this.badgeColor = AppColors.warning,
    this.badgeIcon = Icons.favorite_rounded,
    this.badgeIconColor = Colors.white,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final double badgeSize = size * 0.4;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(size * 0.3),
                boxShadow:
                    boxShadow ??
                    const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 25,
                        offset: Offset(0, 12),
                      ),
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
              ),
              child: Icon(
                Icons.location_on_outlined,
                size: size * 0.5,
                color: iconColor,
              ),
            ),
            Positioned(
              top: -size * 0.1,
              right: -size * 0.1,
              child: Container(
                width: badgeSize,
                height: badgeSize,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  badgeIcon,
                  size: badgeSize * 0.48,
                  color: badgeIconColor,
                ),
              ),
            ),
          ],
        ),
        if (showTitle) ...<Widget>[
          const SizedBox(width: 12),
          Text(
            'PlacePals',
            style: AppTextStyles.heading4.copyWith(
              fontSize: titleSize,
              color: titleColor,
            ),
          ),
        ],
      ],
    );
  }
}
