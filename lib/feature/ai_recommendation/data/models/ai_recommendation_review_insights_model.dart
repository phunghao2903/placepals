import '../../domain/entities/ai_recommendation_review_insights.dart';
import 'ai_recommendation_review_breakdown_model.dart';
import 'ai_recommendation_review_item_model.dart';

class AiRecommendationReviewInsightsModel {
  final String title;
  final String summaryTitle;
  final String sentimentValue;
  final String sentimentLabel;
  final String basedOnLabel;
  final List<AiRecommendationReviewBreakdownModel> breakdowns;
  final String themesTitle;
  final List<String> themes;
  final String transparencyTitle;
  final String transparencySubtitle;
  final String recentReviewsTitle;
  final String sortLabel;
  final List<AiRecommendationReviewItemModel> reviews;

  const AiRecommendationReviewInsightsModel({
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

  AiRecommendationReviewInsights toEntity() {
    return AiRecommendationReviewInsights(
      title: title,
      summaryTitle: summaryTitle,
      sentimentValue: sentimentValue,
      sentimentLabel: sentimentLabel,
      basedOnLabel: basedOnLabel,
      breakdowns: breakdowns.map((item) => item.toEntity()).toList(),
      themesTitle: themesTitle,
      themes: themes,
      transparencyTitle: transparencyTitle,
      transparencySubtitle: transparencySubtitle,
      recentReviewsTitle: recentReviewsTitle,
      sortLabel: sortLabel,
      reviews: reviews.map((item) => item.toEntity()).toList(),
    );
  }
}
