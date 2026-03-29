import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x120F172A),
            blurRadius: 24,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          _BottomBarItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isActive: true,
          ),
          _BottomBarItem(icon: Icons.bookmark_border_rounded, label: 'Saved'),
          _CenterActionButton(),
          _BottomBarItem(icon: Icons.sos_rounded, label: 'SOS'),
          _BottomBarItem(icon: Icons.person_outline_rounded, label: 'Profile'),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _BottomBarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: color,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _CenterActionButton extends StatelessWidget {
  const _CenterActionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x3DFF6B5A),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(Icons.add_rounded, size: 34, color: Colors.white),
    );
  }
}
