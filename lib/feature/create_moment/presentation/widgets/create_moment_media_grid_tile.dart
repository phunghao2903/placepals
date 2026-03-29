import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_photo.dart';

class CreateMomentMediaGridTile extends StatelessWidget {
  final CreateMomentPhoto photo;
  final int selectionIndex;
  final VoidCallback onTap;

  const CreateMomentMediaGridTile({
    super.key,
    required this.photo,
    required this.selectionIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: photo.isPlaceholder ? AppColors.surfaceMuted : null,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (!photo.isPlaceholder && photo.imagePath != null)
                ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.asset(photo.imagePath!, fit: BoxFit.cover),
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0x1AF27F0D),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      photo.label,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              if (!photo.isPlaceholder)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: selectionIndex > 0
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: SemanticTextColors.onBrand,
                        width: 1.4,
                      ),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: selectionIndex > 0
                        ? Text(
                            '$selectionIndex',
                            style: AppTextStyles.caption.copyWith(
                              color: SemanticTextColors.onBrand,
                              fontSize: 11,
                            ),
                          )
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
