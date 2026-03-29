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
    final Color background =
        isSelected ? AppSemanticColors.primary : Colors.white;
    final Color foreground = isSelected ? Colors.white : AppColors.textPrimary;
    final Color border =
        isSelected ? BrandColors.primary500 : NeutralColors.neutral300;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
            boxShadow: <BoxShadow>[
              if (isSelected)
                const BoxShadow(
                  color: Color(0x1AFF6B5A),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.16)
                        : BrandColors.primary50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _iconFor(iconKey),
                    size: 22,
                    color: isSelected
                        ? Colors.white
                        : AppSemanticColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
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
        return Icons.explore_off_rounded;
      case 'unsafe':
        return Icons.security_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
