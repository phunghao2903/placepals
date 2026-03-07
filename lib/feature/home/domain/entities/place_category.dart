class PlaceCategory {
  final String id;
  final String label;
  final bool isSelected;

  const PlaceCategory({
    required this.id,
    required this.label,
    this.isSelected = false,
  });

  PlaceCategory copyWith({
    String? id,
    String? label,
    bool? isSelected,
  }) {
    return PlaceCategory(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
