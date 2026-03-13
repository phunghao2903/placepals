import '../../domain/entities/search_destination.dart';

class SearchDestinationModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final double rating;
  final String categoryMeta;
  final String socialText;
  final int socialAvatarCount;
  final bool isFavorite;
  final bool isLiked;

  const SearchDestinationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.rating,
    required this.categoryMeta,
    required this.socialText,
    required this.socialAvatarCount,
    required this.isFavorite,
    required this.isLiked,
  });

  SearchDestination toEntity() {
    return SearchDestination(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      rating: rating,
      categoryMeta: categoryMeta,
      socialText: socialText,
      socialAvatarCount: socialAvatarCount,
      isFavorite: isFavorite,
      isLiked: isLiked,
    );
  }
}
