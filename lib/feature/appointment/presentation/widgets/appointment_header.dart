import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AppointmentHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const AppointmentHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onClose,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.close_rounded,
                  size: 26,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                title,
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
