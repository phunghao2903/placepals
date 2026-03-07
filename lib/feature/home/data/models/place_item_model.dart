import '../../domain/entities/place_item.dart';

class PlaceItemModel {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final String distance;
  final double rating;
  final bool isOpen;
  final bool isFavorite;

  const PlaceItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.distance,
    required this.rating,
    required this.isOpen,
    required this.isFavorite,
  });

  PlaceItem toEntity() {
    return PlaceItem(
      id: id,
      name: name,
      category: category,
      imagePath: imagePath,
      distance: distance,
      rating: rating,
      isOpen: isOpen,
      isFavorite: isFavorite,
    );
  }
}
