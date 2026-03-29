import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/search_destination.dart';

class SearchDestinationCard extends StatelessWidget {
  final SearchDestination destination;
  final String query;
  final VoidCallback onToggleFavorite;

  const SearchDestinationCard({
    super.key,
    required this.destination,
    required this.query,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0E8E6), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  destination.imagePath,
                  width: 118,
                  height: 118,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Color(0xFFF2B233),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        destination.rating.toStringAsFixed(1),
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 118),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _HighlightedTitle(
                          title: destination.title,
                          query: query,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onToggleFavorite,
                        child: Icon(
                          destination.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_rounded,
                          color: destination.isFavorite
                              ? const Color(0xFFFF2D2D)
                              : const Color(0xFFA8AFB8),
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    destination.categoryMeta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      _AvatarStack(
                        count: destination.socialAvatarCount,
                        showPlus: destination.socialText == 'Pals here',
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          destination.socialText == 'Pals here'
                              ? 'Pals here'
                              : 'Like visted',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightedTitle extends StatelessWidget {
  final String title;
  final String query;

  const _HighlightedTitle({required this.title, required this.query});

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();
    final normalizedTitle = title.toLowerCase();
    final matchIndex = normalizedQuery.isEmpty
        ? -1
        : normalizedTitle.indexOf(normalizedQuery);

    if (matchIndex < 0) {
      return Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.heading4.copyWith(
          color: AppColors.textPrimary,
          fontSize: 23,
          height: 1.08,
        ),
      );
    }

    final before = title.substring(0, matchIndex);
    final match = title.substring(
      matchIndex,
      matchIndex + normalizedQuery.length,
    );
    final after = title.substring(matchIndex + normalizedQuery.length);

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: AppTextStyles.heading4.copyWith(
          color: AppColors.textPrimary,
          fontSize: 23,
          height: 1.08,
        ),
        children: <TextSpan>[
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: const TextStyle(color: AppColors.primary),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final int count;
  final bool showPlus;

  const _AvatarStack({required this.count, required this.showPlus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: showPlus ? 98 : 40,
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (int index = 0; index < count && index < 2; index++)
            Positioned(
              left: index * 28,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (showPlus)
            Positioned(
              left: 56,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '+3',
                    style: AppTextStyles.body1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
