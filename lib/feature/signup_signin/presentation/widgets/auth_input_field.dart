import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData leadingIcon;
  final Widget? trailing;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final double fieldHeight;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;

  const AuthInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.leadingIcon,
    required this.onChanged,
    this.trailing,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.fieldHeight = 58.15,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 16,
    ),
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: AppColors.border,
      width: 1.1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: AppTextStyles.body1.copyWith(
            color: AppColors.textPrimary,
            height: 1,
          ),
          decoration: InputDecoration(
            constraints: BoxConstraints(minHeight: fieldHeight),
            hintText: hintText,
            hintStyle: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
              height: 1,
            ),
            errorText: errorText,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              leadingIcon,
              size: 20,
              color: AppColors.textSecondary,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 52,
              minHeight: 20,
            ),
            suffixIcon: trailing,
            contentPadding: contentPadding,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: borderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
