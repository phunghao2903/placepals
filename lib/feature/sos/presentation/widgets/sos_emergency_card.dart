import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SosEmergencyCard extends StatelessWidget {
  final String title;
  final String iconKey;
  final bool isSelected;
  final VoidCallback onTap;

  const SosEmergencyCard({
    super.key,
    required this.title,
    required this.iconKey,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isSelected ? AppSemanticColors.primary : Colors.white;
    final foreground = isSelected ? Colors.white : AppColors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          width: 155,
          height: 123,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconFor(iconKey),
                  size: 34,
                  color: isSelected ? Colors.black : const Color(0xFF4D5669),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'vehicle':
        return Icons.directions_car_filled_rounded;
      case 'medical':
        return Icons.medical_services_rounded;
      case 'lost':
        return Icons.location_off_rounded;
      case 'unsafe':
        return Icons.error_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
