import '../../domain/entities/ai_recommendation_trip_trend_spot.dart';

class AiRecommendationTripTrendSpotModel {
  final String id;
  final String title;
  final String subtitle;
  final String statusLabel;
  final bool isPositiveStatus;
  final String? highlightLabel;
  final String? socialProofLabel;
  final String imagePath;

  const AiRecommendationTripTrendSpotModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.isPositiveStatus,
    required this.imagePath,
    this.highlightLabel,
    this.socialProofLabel,
  });

  AiRecommendationTripTrendSpot toEntity() {
    return AiRecommendationTripTrendSpot(
      id: id,
      title: title,
      subtitle: subtitle,
      statusLabel: statusLabel,
      isPositiveStatus: isPositiveStatus,
      imagePath: imagePath,
      highlightLabel: highlightLabel,
      socialProofLabel: socialProofLabel,
    );
  }
}
