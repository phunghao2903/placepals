import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SearchBarInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onBack;

  const SearchBarInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7E9E7),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF7E9E7),
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      cursorColor: AppColors.primary,
                      style: AppTextStyles.heading4.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        height: 1.1,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        filled: true,
                        fillColor: const Color(0xFFF7E9E7),
                        hintText: hintText,
                        hintStyle: AppTextStyles.heading4.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 1,
                  height: 28,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.tune_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
