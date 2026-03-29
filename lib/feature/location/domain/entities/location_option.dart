class LocationOption {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isPopular;
  final bool isCurrentLocation;

  const LocationOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isPopular,
    required this.isCurrentLocation,
  });
}
