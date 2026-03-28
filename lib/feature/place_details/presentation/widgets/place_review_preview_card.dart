import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_details_feed.dart';

class PlaceReviewPreviewCard extends StatelessWidget {
  final PlaceReviewPreview review;
  final VoidCallback? onTap;

  const PlaceReviewPreviewCard({
    super.key,
    required this.review,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0FAB332A),
                blurRadius: 40,
                offset: Offset(0, 24),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0x1AAB332A),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: review.avatarImagePath != null
                          ? Image.asset(review.avatarImagePath!, fit: BoxFit.cover)
                          : Container(
                              color: const Color(0xFFF0EDEC),
                              alignment: Alignment.center,
                              child: Text(
                                review.initials,
                                style: AppTextStyles.heading7.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          review.author,
                          style: AppTextStyles.heading6.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List<Widget>.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Icon(
                                index < review.rating
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                size: 12,
                                color: AppColors.warning,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                review.content,
                style: AppTextStyles.heading6.copyWith(
                  height: 1.35,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
