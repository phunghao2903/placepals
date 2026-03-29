class AiRecommendationTripTraveler {
  final String id;
  final String name;
  final String matchLabel;
  final String? imagePath;
  final bool isOnline;
  final bool isDiscoverCard;

  const AiRecommendationTripTraveler({
    required this.id,
    required this.name,
    required this.matchLabel,
    this.imagePath,
    this.isOnline = false,
    this.isDiscoverCard = false,
  });
}
