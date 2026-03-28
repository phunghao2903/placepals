import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_details_feed.dart';

class PlaceFeatureChip extends StatelessWidget {
  final PlaceDetailTag tag;

  const PlaceFeatureChip({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDEC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            _resolveIcon(tag.iconKey),
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            tag.label,
            style: AppTextStyles.heading7.copyWith(
              color: const Color(0xFF1B1C1B),
            ),
          ),
        ],
      ),
    );
  }

  IconData _resolveIcon(String iconKey) {
    return switch (iconKey) {
      'bakery' => Icons.bakery_dining_outlined,
      'wifi' => Icons.wifi_rounded,
      _ => Icons.coffee_outlined,
    };
  }
}
