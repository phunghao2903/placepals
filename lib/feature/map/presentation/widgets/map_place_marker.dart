import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class MapPlaceMarker extends StatelessWidget {
  final String rating;
  final bool isSelected;
  final VoidCallback? onTap;

  const MapPlaceMarker({
    super.key,
    required this.rating,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: isSelected ? 1.05 : 1,
        child: SizedBox(
          width: 32,
          height: 46,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              const Positioned(
                top: 4,
                child: Icon(
                  Icons.location_on_rounded,
                  size: 42,
                  color: AppColors.primary,
                ),
              ),
              Container(
                width: 32,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: isSelected ? 2 : 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  rating,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                    fontSize: 14,
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
