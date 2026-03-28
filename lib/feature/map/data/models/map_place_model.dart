import '../../domain/entities/map_place.dart';
import 'map_guide_model.dart';

class MapPlaceModel {
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
  final List<MapGuideModel> relatedGuides;

  const MapPlaceModel({
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

  MapPlace toEntity() {
    return MapPlace(
      id: id,
      title: title,
      categoryLabel: categoryLabel,
      priceLabel: priceLabel,
      rating: rating,
      reviewLabel: reviewLabel,
      distanceLabel: distanceLabel,
      availabilityLabel: availabilityLabel,
      recommendationLabel: recommendationLabel,
      imagePath: imagePath,
      heroImagePath: heroImagePath,
      locationTitle: locationTitle,
      locationSubtitle: locationSubtitle,
      openStatusLabel: openStatusLabel,
      closeStatusLabel: closeStatusLabel,
      hoursLabel: hoursLabel,
      noteHint: noteHint,
      isSaved: isSaved,
      friendAvatarPaths: friendAvatarPaths,
      relatedGuides: relatedGuides.map((item) => item.toEntity()).toList(),
    );
  }
}
