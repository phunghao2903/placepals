import '../../domain/entities/ai_recommendation_highlight.dart';

class AiRecommendationHighlightModel {
  final String id;
  final String title;
  final String description;
  final String iconKey;

  const AiRecommendationHighlightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconKey,
  });

  AiRecommendationHighlight toEntity() {
    return AiRecommendationHighlight(
      id: id,
      title: title,
      description: description,
      iconKey: iconKey,
    );
  }
}
