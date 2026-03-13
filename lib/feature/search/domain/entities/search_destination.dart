class SearchDestination {
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

  const SearchDestination({
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

  SearchDestination copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imagePath,
    double? rating,
    String? categoryMeta,
    String? socialText,
    int? socialAvatarCount,
    bool? isFavorite,
    bool? isLiked,
  }) {
    return SearchDestination(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      categoryMeta: categoryMeta ?? this.categoryMeta,
      socialText: socialText ?? this.socialText,
      socialAvatarCount: socialAvatarCount ?? this.socialAvatarCount,
      isFavorite: isFavorite ?? this.isFavorite,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
