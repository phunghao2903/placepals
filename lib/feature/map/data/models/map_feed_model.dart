import '../../domain/entities/map_feed.dart';
import 'map_category_model.dart';
import 'map_friend_filter_model.dart';
import 'map_marker_model.dart';

class MapFeedModel {
  final String searchHint;
  final List<MapFriendFilterModel> friendFilters;
  final List<MapCategoryModel> categories;
  final List<MapMarkerModel> markers;

  const MapFeedModel({
    required this.searchHint,
    required this.friendFilters,
    required this.categories,
    required this.markers,
  });

  MapFeed toEntity() {
    return MapFeed(
      searchHint: searchHint,
      friendFilters: friendFilters.map((item) => item.toEntity()).toList(),
      categories: categories.map((item) => item.toEntity()).toList(),
      markers: markers.map((item) => item.toEntity()).toList(),
    );
  }
}
