class MapGuide {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String badgeLabel;

  const MapGuide({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.badgeLabel = 'Guide',
  });
}
