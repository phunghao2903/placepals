import '../../domain/entities/ai_recommendation_review_breakdown.dart';

class AiRecommendationReviewBreakdownModel {
  final String label;
  final String valueLabel;
  final double progress;

  const AiRecommendationReviewBreakdownModel({
    required this.label,
    required this.valueLabel,
    required this.progress,
  });

  AiRecommendationReviewBreakdown toEntity() {
    return AiRecommendationReviewBreakdown(
      label: label,
      valueLabel: valueLabel,
      progress: progress,
    );
  }
}
