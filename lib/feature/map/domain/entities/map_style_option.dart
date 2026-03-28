enum MapStyleType { standard, satellite, terrain, nightMode }

class MapStyleOption {
  final String id;
  final String title;
  final MapStyleType type;
  final bool isSelected;

  const MapStyleOption({
    required this.id,
    required this.title,
    required this.type,
    required this.isSelected,
  });

  MapStyleOption copyWith({
    String? id,
    String? title,
    MapStyleType? type,
    bool? isSelected,
  }) {
    return MapStyleOption(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
