import 'ai_recommendation_place_guide.dart';

class AiRecommendationLocationDetail {
  final String title;
  final String category;
  final String priceLabel;
  final double rating;
  final String reviewsLabel;
  final String addressTitle;
  final String addressSubtitle;
  final String statusLabel;
  final String closingLabel;
  final String hoursLabel;
  final String notesTitle;
  final String notePlaceholder;
  final String guidesTitle;
  final String guidesActionLabel;
  final String directionsLabel;
  final String imagePath;
  final List<AiRecommendationPlaceGuide> guides;

  const AiRecommendationLocationDetail({
    required this.title,
    required this.category,
    required this.priceLabel,
    required this.rating,
    required this.reviewsLabel,
    required this.addressTitle,
    required this.addressSubtitle,
    required this.statusLabel,
    required this.closingLabel,
    required this.hoursLabel,
    required this.notesTitle,
    required this.notePlaceholder,
    required this.guidesTitle,
    required this.guidesActionLabel,
    required this.directionsLabel,
    required this.imagePath,
    required this.guides,
  });
}
