import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SocialAuthButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget leading;
  final VoidCallback? onTap;
  final BorderSide? borderSide;
  final List<BoxShadow>? boxShadow;
  final double height;
  final double borderRadius;

  const SocialAuthButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.leading,
    this.onTap,
    this.borderSide,
    this.boxShadow,
    this.height = 46.19,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Ink(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: borderSide != null ? Border.fromBorderSide(borderSide!) : null,
              boxShadow:
                  boxShadow ??
                  <BoxShadow>[
                    if (backgroundColor == Colors.white)
                      const BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                  ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                leading,
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTextStyles.body2.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
