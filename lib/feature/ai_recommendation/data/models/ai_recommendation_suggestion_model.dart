import '../../domain/entities/ai_recommendation_suggestion.dart';

class AiRecommendationSuggestionModel {
  final String id;
  final String label;
  final bool isSelected;

  const AiRecommendationSuggestionModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  AiRecommendationSuggestion toEntity() {
    return AiRecommendationSuggestion(
      id: id,
      label: label,
      isSelected: isSelected,
    );
  }
}
