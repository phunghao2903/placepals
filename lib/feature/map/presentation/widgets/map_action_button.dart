import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class MapActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const MapActionButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, size: 25, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
