class MapCategory {
  final String id;
  final String label;
  final String? iconAsset;
  final bool isSelected;

  const MapCategory({
    required this.id,
    required this.label,
    this.iconAsset,
    this.isSelected = false,
  });

  MapCategory copyWith({
    String? id,
    String? label,
    String? iconAsset,
    bool? isSelected,
  }) {
    return MapCategory(
      id: id ?? this.id,
      label: label ?? this.label,
      iconAsset: iconAsset ?? this.iconAsset,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
