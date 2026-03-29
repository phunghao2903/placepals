import '../../domain/entities/ai_recommendation_trip_vibe_option.dart';

class AiRecommendationTripVibeOptionModel {
  final String id;
  final String emoji;
  final String label;

  const AiRecommendationTripVibeOptionModel({
    required this.id,
    required this.emoji,
    required this.label,
  });

  AiRecommendationTripVibeOption toEntity() {
    return AiRecommendationTripVibeOption(
      id: id,
      emoji: emoji,
      label: label,
    );
  }
}
