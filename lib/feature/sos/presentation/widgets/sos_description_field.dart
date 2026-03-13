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
      width: 331,
      height: 94,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: AppTextStyles.body2.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTextStyles.body2.copyWith(
            color: const Color(0xFFE8E0DF),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 18,
            minHeight: 18,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Icon(
              Icons.edit_note_rounded,
              size: 18,
              color: Color(0xFF7A8090),
            ),
          ),
        ),
      ),
    );
  }
}
