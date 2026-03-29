import '../../domain/entities/ai_recommendation_location_detail.dart';
import 'ai_recommendation_place_guide_model.dart';

class AiRecommendationLocationDetailModel {
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
  final List<AiRecommendationPlaceGuideModel> guides;

  const AiRecommendationLocationDetailModel({
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

  AiRecommendationLocationDetail toEntity() {
    return AiRecommendationLocationDetail(
      title: title,
      category: category,
      priceLabel: priceLabel,
      rating: rating,
      reviewsLabel: reviewsLabel,
      addressTitle: addressTitle,
      addressSubtitle: addressSubtitle,
      statusLabel: statusLabel,
      closingLabel: closingLabel,
      hoursLabel: hoursLabel,
      notesTitle: notesTitle,
      notePlaceholder: notePlaceholder,
      guidesTitle: guidesTitle,
      guidesActionLabel: guidesActionLabel,
      directionsLabel: directionsLabel,
      imagePath: imagePath,
      guides: guides.map((item) => item.toEntity()).toList(),
    );
  }
}
