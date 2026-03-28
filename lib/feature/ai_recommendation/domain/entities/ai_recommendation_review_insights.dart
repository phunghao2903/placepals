import 'ai_recommendation_review_breakdown.dart';
import 'ai_recommendation_review_item.dart';

class AiRecommendationReviewInsights {
  final String title;
  final String summaryTitle;
  final String sentimentValue;
  final String sentimentLabel;
  final String basedOnLabel;
  final List<AiRecommendationReviewBreakdown> breakdowns;
  final String themesTitle;
  final List<String> themes;
  final String transparencyTitle;
  final String transparencySubtitle;
  final String recentReviewsTitle;
  final String sortLabel;
  final List<AiRecommendationReviewItem> reviews;

  const AiRecommendationReviewInsights({
    required this.title,
    required this.summaryTitle,
    required this.sentimentValue,
    required this.sentimentLabel,
    required this.basedOnLabel,
    required this.breakdowns,
    required this.themesTitle,
    required this.themes,
    required this.transparencyTitle,
    required this.transparencySubtitle,
    required this.recentReviewsTitle,
    required this.sortLabel,
    required this.reviews,
  });
}
