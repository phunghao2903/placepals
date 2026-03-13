import '../../domain/entities/ai_recommendation_result_item.dart';
import 'ai_recommendation_result_tag_model.dart';

class AiRecommendationResultItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String matchLabel;
  final double rating;
  final String metaLine;
  final List<AiRecommendationResultTagModel> tags;

  const AiRecommendationResultItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.matchLabel,
    required this.rating,
    required this.metaLine,
    required this.tags,
  });

  AiRecommendationResultItem toEntity() {
    return AiRecommendationResultItem(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      matchLabel: matchLabel,
      rating: rating,
      metaLine: metaLine,
      tags: tags.map((item) => item.toEntity()).toList(),
    );
  }
}
