import 'map_category.dart';
import 'map_friend_filter.dart';
import 'map_marker.dart';
import 'map_overlay_setting.dart';
import 'map_place.dart';
import 'map_search_place.dart';
import 'map_style_option.dart';

class MapFeed {
  final String searchHint;
  final String locationTitle;
  final String locationSearchHint;
  final String pickOnMapLabel;
  final String nearbyPlacesTitle;
  final List<MapSearchPlace> nearbyPlaces;
  final List<MapFriendFilter> friendFilters;
  final List<MapCategory> categories;
  final List<MapMarker> markers;
  final MapPlace previewPlace;
  final MapPlace detailPlace;
  final List<MapStyleOption> styleOptions;
  final List<MapOverlaySetting> overlaySettings;

  const MapFeed({
    required this.searchHint,
    required this.locationTitle,
    required this.locationSearchHint,
    required this.pickOnMapLabel,
    required this.nearbyPlacesTitle,
    required this.nearbyPlaces,
    required this.friendFilters,
    required this.categories,
    required this.markers,
    required this.previewPlace,
    required this.detailPlace,
    required this.styleOptions,
    required this.overlaySettings,
  });

  MapFeed copyWith({
    String? searchHint,
    String? locationTitle,
    String? locationSearchHint,
    String? pickOnMapLabel,
    String? nearbyPlacesTitle,
    List<MapSearchPlace>? nearbyPlaces,
    List<MapFriendFilter>? friendFilters,
    List<MapCategory>? categories,
    List<MapMarker>? markers,
    MapPlace? previewPlace,
    MapPlace? detailPlace,
    List<MapStyleOption>? styleOptions,
    List<MapOverlaySetting>? overlaySettings,
  }) {
    return MapFeed(
      searchHint: searchHint ?? this.searchHint,
      locationTitle: locationTitle ?? this.locationTitle,
      locationSearchHint: locationSearchHint ?? this.locationSearchHint,
      pickOnMapLabel: pickOnMapLabel ?? this.pickOnMapLabel,
      nearbyPlacesTitle: nearbyPlacesTitle ?? this.nearbyPlacesTitle,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      friendFilters: friendFilters ?? this.friendFilters,
      categories: categories ?? this.categories,
      markers: markers ?? this.markers,
      previewPlace: previewPlace ?? this.previewPlace,
      detailPlace: detailPlace ?? this.detailPlace,
      styleOptions: styleOptions ?? this.styleOptions,
      overlaySettings: overlaySettings ?? this.overlaySettings,
    );
  }
}
