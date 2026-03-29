import '../../domain/entities/ai_recommendation_map_pick.dart';

class AiRecommendationMapPickModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String markerLabel;
  final String? badgeLabel;
  final String? highlightLabel;
  final String distanceLabel;
  final double rating;

  const AiRecommendationMapPickModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.markerLabel,
    required this.distanceLabel,
    required this.rating,
    this.badgeLabel,
    this.highlightLabel,
  });

  AiRecommendationMapPick toEntity() {
    return AiRecommendationMapPick(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      markerLabel: markerLabel,
      badgeLabel: badgeLabel,
      highlightLabel: highlightLabel,
      distanceLabel: distanceLabel,
      rating: rating,
    );
  }
}
