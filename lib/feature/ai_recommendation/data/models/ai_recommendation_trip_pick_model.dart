import '../../domain/entities/ai_recommendation_trip_pick.dart';

class AiRecommendationTripPickModel {
  final String id;
  final String title;
  final String subtitle;
  final String matchLabel;
  final String reason;
  final String imagePath;

  const AiRecommendationTripPickModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.matchLabel,
    required this.reason,
    required this.imagePath,
  });

  AiRecommendationTripPick toEntity() {
    return AiRecommendationTripPick(
      id: id,
      title: title,
      subtitle: subtitle,
      matchLabel: matchLabel,
      reason: reason,
      imagePath: imagePath,
    );
  }
}
