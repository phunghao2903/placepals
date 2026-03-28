import '../../domain/entities/ai_recommendation_progress_step.dart';

class AiRecommendationProgressStepModel {
  final String id;
  final String label;

  const AiRecommendationProgressStepModel({
    required this.id,
    required this.label,
  });

  AiRecommendationProgressStep toEntity() {
    return AiRecommendationProgressStep(id: id, label: label);
  }
}
