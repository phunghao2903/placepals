import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_details_feed.dart';

class PlaceMapSnippetCard extends StatelessWidget {
  final PlaceMapSnippetData data;
  final VoidCallback? onDirectionsTap;

  const PlaceMapSnippetCard({
    super.key,
    required this.data,
    this.onDirectionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 256,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0x1AE0BFBB)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(data.imagePath, fit: BoxFit.cover),
                const ColoredBox(color: Color(0x0DAB332A)),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: onDirectionsTap,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      icon: const Icon(Icons.diamond_outlined, size: 18),
                      label: Text(
                        data.buttonLabel,
                        style: AppTextStyles.heading6.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F3F2),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data.openingHoursTitle,
                      style: AppTextStyles.heading3.copyWith(
                        color: const Color(0xFF1B1C1B),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.access_time_rounded,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...data.openingHours.map((item) {
                final Color color = item.isHighlighted
                    ? AppColors.primary
                    : AppColors.textPrimary;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          item.dayLabel,
                          style: AppTextStyles.heading7.copyWith(color: color),
                        ),
                      ),
                      Text(
                        item.hoursLabel,
                        style: AppTextStyles.heading7.copyWith(color: color),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
