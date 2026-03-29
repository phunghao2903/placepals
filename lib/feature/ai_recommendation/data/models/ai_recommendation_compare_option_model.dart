import '../../domain/entities/ai_recommendation_compare_option.dart';

class AiRecommendationCompareOptionModel {
  final String id;
  final String title;
  final String imagePath;
  final double rating;
  final String reviewsLabel;
  final String matchScoreLabel;
  final String distanceLabel;
  final String priceLabel;
  final List<String> vibes;
  final String reasonTitle;
  final String reasonDescription;
  final bool isTopMatch;

  const AiRecommendationCompareOptionModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviewsLabel,
    required this.matchScoreLabel,
    required this.distanceLabel,
    required this.priceLabel,
    required this.vibes,
    required this.reasonTitle,
    required this.reasonDescription,
    this.isTopMatch = false,
  });

  AiRecommendationCompareOption toEntity() {
    return AiRecommendationCompareOption(
      id: id,
      title: title,
      imagePath: imagePath,
      rating: rating,
      reviewsLabel: reviewsLabel,
      matchScoreLabel: matchScoreLabel,
      distanceLabel: distanceLabel,
      priceLabel: priceLabel,
      vibes: vibes,
      reasonTitle: reasonTitle,
      reasonDescription: reasonDescription,
      isTopMatch: isTopMatch,
    );
  }
}
