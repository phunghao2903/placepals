import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SosDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SosDescriptionField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.neutral300),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        minLines: 3,
        maxLines: 4,
        textAlignVertical: TextAlignVertical.top,
        style: AppTextStyles.body2.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTextStyles.body2.copyWith(
            color: NeutralColors.neutral700,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 18,
            minHeight: 18,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(top: 34),
            child: Icon(
              Icons.expand_more_rounded,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
