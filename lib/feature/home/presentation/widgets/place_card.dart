import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_item.dart';

class PlaceCard extends StatelessWidget {
  final PlaceItem place;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;

  const PlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 31),
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _PlaceCardImage(
                place: place,
                onToggleFavorite: onToggleFavorite,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _PlaceCardHeader(place: place),
                    const SizedBox(height: 2),
                    _PlaceCardMeta(place: place),
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

class _PlaceCardImage extends StatelessWidget {
  final PlaceItem place;
  final VoidCallback? onToggleFavorite;

  const _PlaceCardImage({
    required this.place,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: SizedBox(
        height: 199,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                place.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 12,
              left: 14,
              child: Material(
                color: place.isFavorite
                    ? ComponentColors.favoriteActiveBackground
                    : ComponentColors.favoriteDefaultBackground,
                borderRadius: BorderRadius.circular(25),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onToggleFavorite,
                  child: SizedBox(
                    width: 35,
                    height: 25,
                    child: Icon(
                      place.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 18,
                      color: place.isFavorite
                          ? ComponentColors.favoriteActiveIcon
                          : ComponentColors.favoriteDefaultIcon,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 17,
              child: Container(
                height: 25,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      place.rating.toStringAsFixed(1),
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceCardHeader extends StatelessWidget {
  final PlaceItem place;

  const _PlaceCardHeader({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          height: 18,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            place.distance,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceCardMeta extends StatelessWidget {
  final PlaceItem place;

  const _PlaceCardMeta({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          place.isOpen ? 'Open Now' : 'Closed',
          style: AppTextStyles.caption.copyWith(
            color: place.isOpen
                ? AppColors.success
                : AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 6),
        const _MetaDot(),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '${place.category} • &&',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaDot extends StatelessWidget {
  const _MetaDot();

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: AppTextStyles.caption.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }
}
