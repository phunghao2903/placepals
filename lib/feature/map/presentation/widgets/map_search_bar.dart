import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class MapSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const MapSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.search_rounded,
            color: AppColors.textPrimary,
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              cursorColor: AppColors.primary,
              style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
