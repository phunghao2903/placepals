import 'ai_recommendation_result_tag.dart';

class AiRecommendationResultItem {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String matchLabel;
  final double rating;
  final String metaLine;
  final List<AiRecommendationResultTag> tags;

  const AiRecommendationResultItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.matchLabel,
    required this.rating,
    required this.metaLine,
    required this.tags,
  });
}
