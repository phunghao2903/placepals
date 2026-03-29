import 'map_guide.dart';

class MapPlace {
  final String id;
  final String title;
  final String categoryLabel;
  final String priceLabel;
  final double rating;
  final String reviewLabel;
  final String distanceLabel;
  final String availabilityLabel;
  final String recommendationLabel;
  final String imagePath;
  final String heroImagePath;
  final String locationTitle;
  final String locationSubtitle;
  final String openStatusLabel;
  final String closeStatusLabel;
  final String hoursLabel;
  final String noteHint;
  final bool isSaved;
  final List<String> friendAvatarPaths;
  final List<MapGuide> relatedGuides;

  const MapPlace({
    required this.id,
    required this.title,
    required this.categoryLabel,
    required this.priceLabel,
    required this.rating,
    required this.reviewLabel,
    required this.distanceLabel,
    required this.availabilityLabel,
    required this.recommendationLabel,
    required this.imagePath,
    required this.heroImagePath,
    required this.locationTitle,
    required this.locationSubtitle,
    required this.openStatusLabel,
    required this.closeStatusLabel,
    required this.hoursLabel,
    required this.noteHint,
    required this.isSaved,
    required this.friendAvatarPaths,
    required this.relatedGuides,
  });

  MapPlace copyWith({
    String? id,
    String? title,
    String? categoryLabel,
    String? priceLabel,
    double? rating,
    String? reviewLabel,
    String? distanceLabel,
    String? availabilityLabel,
    String? recommendationLabel,
    String? imagePath,
    String? heroImagePath,
    String? locationTitle,
    String? locationSubtitle,
    String? openStatusLabel,
    String? closeStatusLabel,
    String? hoursLabel,
    String? noteHint,
    bool? isSaved,
    List<String>? friendAvatarPaths,
    List<MapGuide>? relatedGuides,
  }) {
    return MapPlace(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      priceLabel: priceLabel ?? this.priceLabel,
      rating: rating ?? this.rating,
      reviewLabel: reviewLabel ?? this.reviewLabel,
      distanceLabel: distanceLabel ?? this.distanceLabel,
      availabilityLabel: availabilityLabel ?? this.availabilityLabel,
      recommendationLabel: recommendationLabel ?? this.recommendationLabel,
      imagePath: imagePath ?? this.imagePath,
      heroImagePath: heroImagePath ?? this.heroImagePath,
      locationTitle: locationTitle ?? this.locationTitle,
      locationSubtitle: locationSubtitle ?? this.locationSubtitle,
      openStatusLabel: openStatusLabel ?? this.openStatusLabel,
      closeStatusLabel: closeStatusLabel ?? this.closeStatusLabel,
      hoursLabel: hoursLabel ?? this.hoursLabel,
      noteHint: noteHint ?? this.noteHint,
      isSaved: isSaved ?? this.isSaved,
      friendAvatarPaths: friendAvatarPaths ?? this.friendAvatarPaths,
      relatedGuides: relatedGuides ?? this.relatedGuides,
    );
  }
}
