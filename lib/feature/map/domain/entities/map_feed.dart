import 'map_category.dart';
import 'map_friend_filter.dart';
import 'map_marker.dart';

class MapFeed {
  final String searchHint;
  final List<MapFriendFilter> friendFilters;
  final List<MapCategory> categories;
  final List<MapMarker> markers;

  const MapFeed({
    required this.searchHint,
    required this.friendFilters,
    required this.categories,
    required this.markers,
  });

  MapFeed copyWith({
    String? searchHint,
    List<MapFriendFilter>? friendFilters,
    List<MapCategory>? categories,
    List<MapMarker>? markers,
  }) {
    return MapFeed(
      searchHint: searchHint ?? this.searchHint,
      friendFilters: friendFilters ?? this.friendFilters,
      categories: categories ?? this.categories,
      markers: markers ?? this.markers,
    );
  }
}
