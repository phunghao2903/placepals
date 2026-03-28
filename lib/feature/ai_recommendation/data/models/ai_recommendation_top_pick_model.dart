import '../../domain/entities/ai_recommendation_top_pick.dart';

class AiRecommendationTopPickModel {
  final String title;
  final String category;
  final String distanceLabel;
  final String priceLabel;
  final String matchLabel;
  final String insightTitle;
  final String insightDescription;
  final String imagePath;
  final String ctaLabel;

  const AiRecommendationTopPickModel({
    required this.title,
    required this.category,
    required this.distanceLabel,
    required this.priceLabel,
    required this.matchLabel,
    required this.insightTitle,
    required this.insightDescription,
    required this.imagePath,
    required this.ctaLabel,
  });

  AiRecommendationTopPick toEntity() {
    return AiRecommendationTopPick(
      title: title,
      category: category,
      distanceLabel: distanceLabel,
      priceLabel: priceLabel,
      matchLabel: matchLabel,
      insightTitle: insightTitle,
      insightDescription: insightDescription,
      imagePath: imagePath,
      ctaLabel: ctaLabel,
    );
  }
}
