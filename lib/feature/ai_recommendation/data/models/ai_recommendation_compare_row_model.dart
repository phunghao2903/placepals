import '../../domain/entities/ai_recommendation_compare_row.dart';

class AiRecommendationCompareRowModel {
  final String criteria;
  final String beanValue;
  final String grindValue;
  final String leafValue;

  const AiRecommendationCompareRowModel({
    required this.criteria,
    required this.beanValue,
    required this.grindValue,
    required this.leafValue,
  });

  AiRecommendationCompareRow toEntity() {
    return AiRecommendationCompareRow(
      criteria: criteria,
      beanValue: beanValue,
      grindValue: grindValue,
      leafValue: leafValue,
    );
  }
}
