import '../../domain/entities/ai_recommendation_place_guide.dart';

class AiRecommendationPlaceGuideModel {
  final String title;
  final String subtitle;
  final String imagePath;
  final String label;

  const AiRecommendationPlaceGuideModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.label,
  });

  AiRecommendationPlaceGuide toEntity() {
    return AiRecommendationPlaceGuide(
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      label: label,
    );
  }
}
