import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ProfileActionTile extends StatelessWidget {
  final String label;
  final String iconKey;
  final VoidCallback? onTap;

  const ProfileActionTile({
    super.key,
    required this.label,
    required this.iconKey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          width: 100.5,
          height: 98.2,
          decoration: BoxDecoration(
            color: const Color(0xCCFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: -1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppSemanticColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconFor(iconKey),
                  size: 20,
                  color: AppSemanticColors.primary,
                ),
              ),
              const SizedBox(height: 11),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'friends':
        return Icons.person_add_alt_1_rounded;
      case 'achievements':
        return Icons.workspace_premium_rounded;
      case 'privacy':
        return Icons.lock_outline_rounded;
      default:
        return Icons.circle_outlined;
    }
  }
}
