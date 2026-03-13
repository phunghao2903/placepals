import '../../domain/entities/ai_recommendation_result_tag.dart';

class AiRecommendationResultTagModel {
  final String id;
  final String label;
  final String iconKey;

  const AiRecommendationResultTagModel({
    required this.id,
    required this.label,
    required this.iconKey,
  });

  AiRecommendationResultTag toEntity() {
    return AiRecommendationResultTag(
      id: id,
      label: label,
      iconKey: iconKey,
    );
  }
}
