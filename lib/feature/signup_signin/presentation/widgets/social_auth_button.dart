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

  const SocialAuthButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.leading,
    this.onTap,
    this.borderSide,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Ink(
            height: 48,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18),
              border: borderSide != null ? Border.fromBorderSide(borderSide!) : null,
              boxShadow:
                  boxShadow ??
                  <BoxShadow>[
                    if (backgroundColor == Colors.white)
                      const BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                  ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                leading,
                const SizedBox(width: 10),
                Text(
                  label,
                  style: AppTextStyles.body2.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
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
