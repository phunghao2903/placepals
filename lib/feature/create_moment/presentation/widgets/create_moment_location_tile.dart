import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_place.dart';
import 'create_moment_icon_resolver.dart';

class CreateMomentLocationTile extends StatelessWidget {
  final CreateMomentPlace place;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateMomentLocationTile({
    super.key,
    required this.place,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.2,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppSemanticColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  resolveCreateMomentIcon(place.iconKey),
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      place.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      place.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppSemanticColors.secondary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  place.distance,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
