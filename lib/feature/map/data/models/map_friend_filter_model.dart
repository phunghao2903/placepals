import '../../domain/entities/map_friend_filter.dart';

class MapFriendFilterModel {
  final String id;
  final String label;
  final bool isSelected;

  const MapFriendFilterModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  MapFriendFilter toEntity() {
    return MapFriendFilter(id: id, label: label, isSelected: isSelected);
  }
}
