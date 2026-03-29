import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class HelpSosActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const HelpSosActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color foreground =
        isPrimary ? Colors.white : AppSemanticColors.primary;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isPrimary ? AppSemanticColors.primary : Colors.white,
          side: BorderSide(
            color:
                isPrimary ? AppSemanticColors.primary : BrandColors.primary100,
            width: 1.3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, size: 18, color: foreground),
        label: Text(
          label,
          style: AppTextStyles.body1.copyWith(
            color: foreground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
