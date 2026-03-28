import '../../domain/entities/map_style_option.dart';

class MapStyleOptionModel {
  final String id;
  final String title;
  final MapStyleType type;
  final bool isSelected;

  const MapStyleOptionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.isSelected,
  });

  MapStyleOption toEntity() {
    return MapStyleOption(
      id: id,
      title: title,
      type: type,
      isSelected: isSelected,
    );
  }
}
