class MapFriendFilter {
  final String id;
  final String label;
  final bool isSelected;

  const MapFriendFilter({
    required this.id,
    required this.label,
    this.isSelected = false,
  });

  MapFriendFilter copyWith({String? id, String? label, bool? isSelected}) {
    return MapFriendFilter(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
