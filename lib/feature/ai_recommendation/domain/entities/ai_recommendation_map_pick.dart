class AiRecommendationMapPick {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String markerLabel;
  final String? badgeLabel;
  final String? highlightLabel;
  final String distanceLabel;
  final double rating;

  const AiRecommendationMapPick({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.markerLabel,
    required this.distanceLabel,
    required this.rating,
    this.badgeLabel,
    this.highlightLabel,
  });
}
