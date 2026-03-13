import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_photo.dart';

class CreateMomentPhotoTile extends StatelessWidget {
  final CreateMomentPhoto photo;
  final String addPhotoLabel;

  const CreateMomentPhotoTile({
    super.key,
    required this.photo,
    required this.addPhotoLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (!photo.isPlaceholder && photo.imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          photo.imagePath!,
          width: 175,
          height: 140,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: 175,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.textSecondary,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            addPhotoLabel,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
