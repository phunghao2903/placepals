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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
            ),
            errorText: errorText,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              leadingIcon,
              size: 20,
              color: AppColors.textSecondary,
            ),
            suffixIcon: trailing,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}
