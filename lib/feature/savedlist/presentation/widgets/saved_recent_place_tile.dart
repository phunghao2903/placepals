import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class SavedRecentPlaceTile extends StatelessWidget {
  final RecentPlace place;
  final VoidCallback onTap;
  final bool showTrailingAdd;

  const SavedRecentPlaceTile({
    super.key,
    required this.place,
    required this.onTap,
    this.showTrailingAdd = true,
  });

  @override
  Widget build(BuildContext context) {
    final address = place.address
        .replaceAll('â€¢', '•')
        .replaceAll('â€¦', '…');

    return SizedBox(
      height: 68,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              place.imagePath,
              width: 57,
              height: 57,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  place.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading6.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    Text(
                      '★ ${place.rating.toStringAsFixed(1)}',
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFFF59E0B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '•',
                      style: TextStyle(color: Color(0xFFBBAEA6), fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showTrailingAdd)
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE9E9EB),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.add_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
