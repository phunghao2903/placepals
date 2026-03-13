import '../../domain/entities/map_category.dart';

class MapCategoryModel {
  final String id;
  final String label;
  final String? iconAsset;
  final bool isSelected;

  const MapCategoryModel({
    required this.id,
    required this.label,
    this.iconAsset,
    required this.isSelected,
  });

  MapCategory toEntity() {
    return MapCategory(
      id: id,
      label: label,
      iconAsset: iconAsset,
      isSelected: isSelected,
    );
  }
}
