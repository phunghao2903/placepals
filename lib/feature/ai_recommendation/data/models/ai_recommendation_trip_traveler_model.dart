import '../../domain/entities/ai_recommendation_trip_traveler.dart';

class AiRecommendationTripTravelerModel {
  final String id;
  final String name;
  final String matchLabel;
  final String? imagePath;
  final bool isOnline;
  final bool isDiscoverCard;

  const AiRecommendationTripTravelerModel({
    required this.id,
    required this.name,
    required this.matchLabel,
    this.imagePath,
    this.isOnline = false,
    this.isDiscoverCard = false,
  });

  AiRecommendationTripTraveler toEntity() {
    return AiRecommendationTripTraveler(
      id: id,
      name: name,
      matchLabel: matchLabel,
      imagePath: imagePath,
      isOnline: isOnline,
      isDiscoverCard: isDiscoverCard,
    );
  }
}
