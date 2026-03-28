import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/map_guide.dart';

class MapRelatedGuideCard extends StatelessWidget {
  final MapGuide guide;

  const MapRelatedGuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  guide.imagePath,
                  width: 160,
                  height: 214,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      guide.badgeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            guide.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            guide.subtitle,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
