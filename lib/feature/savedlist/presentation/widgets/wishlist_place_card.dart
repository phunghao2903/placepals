import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class WishlistPlaceCard extends StatelessWidget {
  final WishlistPlace place;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onMarkVisited;
  final VoidCallback? onSaveToCollection;

  const WishlistPlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.onToggleFavorite,
    this.onMarkVisited,
    this.onSaveToCollection,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = place.subtitle
        .replaceAll('Ã¢â‚¬Â¢', '•')
        .replaceAll('â€¢', '•');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        child: Image.asset(
                          place.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (place.badgeLabel != null)
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xCCFFFFFF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            place.badgeLabel!,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xCC2D2D2D),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '★ ${place.rating.toStringAsFixed(1)}',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    if (place.showPlayOverlay)
                      const Positioned.fill(
                        child: Center(
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xD92D2D2D),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Material(
                        color: place.isFavorite
                            ? const Color(0xCCFFF0EF)
                            : const Color(0xCCFFFFFF),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onToggleFavorite,
                          child: SizedBox(
                            width: 34,
                            height: 34,
                            child: Icon(
                              place.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
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
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        if (place.showExternalLinkIcon)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.open_in_new_rounded,
                              size: 14,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
