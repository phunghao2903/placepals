import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? leadingIcon;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<BoxShadow>? boxShadow;

  const AuthPrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.leadingIcon,
    this.height = 56,
    this.borderRadius = 999,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: isLoading ? null : onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow:
                  boxShadow ??
                  const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (leadingIcon != null) ...<Widget>[
                          Icon(leadingIcon, size: 20, color: foregroundColor),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label,
                          style: AppTextStyles.heading3.copyWith(
                            color: foregroundColor,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
