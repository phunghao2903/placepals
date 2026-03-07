class PlaceItem {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final String distance;
  final double rating;
  final bool isOpen;
  final bool isFavorite;

  const PlaceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.distance,
    required this.rating,
    required this.isOpen,
    required this.isFavorite,
  });
}
