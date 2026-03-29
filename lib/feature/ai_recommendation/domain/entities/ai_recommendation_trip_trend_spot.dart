class AiRecommendationTripTrendSpot {
  final String id;
  final String title;
  final String subtitle;
  final String statusLabel;
  final bool isPositiveStatus;
  final String? highlightLabel;
  final String? socialProofLabel;
  final String imagePath;

  const AiRecommendationTripTrendSpot({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.isPositiveStatus,
    required this.imagePath,
    this.highlightLabel,
    this.socialProofLabel,
  });
}
