import '../../domain/entities/ai_recommendation_trip_itinerary_item.dart';

class AiRecommendationTripItineraryItemModel {
  final String id;
  final String timeLabel;
  final String title;
  final String locationLabel;
  final String imagePath;
  final String whyTitle;
  final String whyDescription;
  final String tipTitle;
  final String tipDescription;

  const AiRecommendationTripItineraryItemModel({
    required this.id,
    required this.timeLabel,
    required this.title,
    required this.locationLabel,
    required this.imagePath,
    required this.whyTitle,
    required this.whyDescription,
    required this.tipTitle,
    required this.tipDescription,
  });

  AiRecommendationTripItineraryItem toEntity() {
    return AiRecommendationTripItineraryItem(
      id: id,
      timeLabel: timeLabel,
      title: title,
      locationLabel: locationLabel,
      imagePath: imagePath,
      whyTitle: whyTitle,
      whyDescription: whyDescription,
      tipTitle: tipTitle,
      tipDescription: tipDescription,
    );
  }
}
