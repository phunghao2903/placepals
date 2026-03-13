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

  PlaceItem copyWith({
    String? id,
    String? name,
    String? category,
    String? imagePath,
    String? distance,
    double? rating,
    bool? isOpen,
    bool? isFavorite,
  }) {
    return PlaceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      isOpen: isOpen ?? this.isOpen,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
