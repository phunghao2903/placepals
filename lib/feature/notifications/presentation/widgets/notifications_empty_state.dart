import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class NotificationsEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationsEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
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
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 38,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading4.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101010),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.primary.withValues(alpha: 0.9),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
