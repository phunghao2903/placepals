import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SavedSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Widget? trailing;

  const SavedSearchField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFF4F1F0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF9CA3AF),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: AppTextStyles.body2.copyWith(
                  color: const Color(0xFFB7AAA6),
                ),
              ),
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (trailing != null) ...<Widget>[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}
