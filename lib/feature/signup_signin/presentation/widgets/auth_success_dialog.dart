import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'auth_primary_button.dart';

class AuthSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String highlightMessage;
  final VoidCallback onContinue;

  const AuthSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.highlightMessage,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 44,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading4.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.favorite_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      highlightMessage,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: AppTextStyles.body2.copyWith(
                        color: const Color(0xFFE86152),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            AuthPrimaryButton(label: 'OK', onTap: onContinue),
          ],
        ),
      ),
    );
  }
}
