import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AppointmentEmptyState extends StatelessWidget {
  final String title;
  final String description;

  const AppointmentEmptyState({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0x1AFA8075),
                borderRadius: BorderRadius.circular(36),
              ),
              child: const Icon(
                Icons.group_add_outlined,
                size: 34,
                color: Color(0xFFFA8075),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.heading4.copyWith(
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
