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
    final _ActionPalette palette = _paletteFor(iconKey);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          width: 96,
          height: 88,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFF7EFED)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0F111827),
                blurRadius: 14,
                offset: Offset(0, 8),
                spreadRadius: -8,
              ),
              BoxShadow(
                color: Color(0x12111827),
                blurRadius: 22,
                offset: Offset(0, 14),
                spreadRadius: -16,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _iconFor(iconKey),
                  size: 18,
                  color: palette.foreground,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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

  _ActionPalette _paletteFor(String key) {
    switch (key) {
      case 'friends':
        return const _ActionPalette(
          background: Color(0xFFFFF1EE),
          foreground: Color(0xFFFF6B5A),
        );
      case 'achievements':
        return const _ActionPalette(
          background: Color(0xFFFFF2E7),
          foreground: Color(0xFFFF8B2C),
        );
      case 'privacy':
        return const _ActionPalette(
          background: Color(0xFFEDF4FF),
          foreground: Color(0xFF4C7CFF),
        );
      default:
        return const _ActionPalette(
          background: Color(0xFFF5F5F5),
          foreground: AppColors.textPrimary,
        );
    }
  }
}

class _ActionPalette {
  final Color background;
  final Color foreground;

  const _ActionPalette({
    required this.background,
    required this.foreground,
  });
}
