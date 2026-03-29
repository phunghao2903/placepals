import '../../domain/entities/place_category.dart';

class PlaceCategoryModel {
  final String id;
  final String label;
  final bool isSelected;

  const PlaceCategoryModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  PlaceCategory toEntity() {
    return PlaceCategory(id: id, label: label, isSelected: isSelected);
  }
}
