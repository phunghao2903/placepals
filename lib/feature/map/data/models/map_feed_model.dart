import '../../domain/entities/map_feed.dart';
import 'map_category_model.dart';
import 'map_friend_filter_model.dart';
import 'map_marker_model.dart';
import 'map_overlay_setting_model.dart';
import 'map_place_model.dart';
import 'map_style_option_model.dart';

class MapFeedModel {
  final String searchHint;
  final List<MapFriendFilterModel> friendFilters;
  final List<MapCategoryModel> categories;
  final List<MapMarkerModel> markers;
  final MapPlaceModel previewPlace;
  final MapPlaceModel detailPlace;
  final List<MapStyleOptionModel> styleOptions;
  final List<MapOverlaySettingModel> overlaySettings;

  const MapFeedModel({
    required this.searchHint,
    required this.friendFilters,
    required this.categories,
    required this.markers,
    required this.previewPlace,
    required this.detailPlace,
    required this.styleOptions,
    required this.overlaySettings,
  });

  MapFeed toEntity() {
    return MapFeed(
      searchHint: searchHint,
      friendFilters: friendFilters.map((item) => item.toEntity()).toList(),
      categories: categories.map((item) => item.toEntity()).toList(),
      markers: markers.map((item) => item.toEntity()).toList(),
      previewPlace: previewPlace.toEntity(),
      detailPlace: detailPlace.toEntity(),
      styleOptions: styleOptions.map((item) => item.toEntity()).toList(),
      overlaySettings: overlaySettings.map((item) => item.toEntity()).toList(),
    );
  }
}
