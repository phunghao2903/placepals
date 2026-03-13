import '../models/map_category_model.dart';
import '../models/map_feed_model.dart';
import '../models/map_friend_filter_model.dart';
import '../models/map_marker_model.dart';

abstract class MapLocalDataSource {
  Future<MapFeedModel> getMapFeed();
}

class MapLocalDataSourceImpl implements MapLocalDataSource {
  @override
  Future<MapFeedModel> getMapFeed() async {
    return const MapFeedModel(
      searchHint: 'Seach friend or spots...',
      friendFilters: <MapFriendFilterModel>[
        MapFriendFilterModel(
          id: 'all-friends',
          label: 'All Friends',
          isSelected: true,
        ),
        MapFriendFilterModel(
          id: 'close-friends',
          label: 'Close Friends',
          isSelected: false,
        ),
      ],
      categories: <MapCategoryModel>[
        MapCategoryModel(
          id: 'all',
          label: 'All',
          isSelected: true,
        ),
        MapCategoryModel(
          id: 'coffee',
          label: 'Coffee',
          iconAsset: 'assets/icons/coffe.png',
          isSelected: false,
        ),
        MapCategoryModel(
          id: 'outdoors',
          label: 'Outdoors',
          iconAsset: 'assets/icons/uotdoors.png',
          isSelected: false,
        ),
        MapCategoryModel(
          id: 'bar',
          label: 'Bar',
          iconAsset: 'assets/icons/bar.png',
          isSelected: false,
        ),
      ],
      markers: <MapMarkerModel>[
        MapMarkerModel(
          id: 'marker-4-2',
          rating: '4.2',
          markerLeftRatio: 122 / 390,
          markerTopRatio: 275 / 844,
          avatarLeftRatio: 114 / 390,
          avatarTopRatio: 245 / 844,
        ),
        MapMarkerModel(
          id: 'marker-4-2-b',
          rating: '4.2',
          showMarker: false,
          markerLeftRatio: 122 / 390,
          markerTopRatio: 275 / 844,
          avatarLeftRatio: 136 / 390,
          avatarTopRatio: 245 / 844,
          avatarTintHex: 0xFFF4C27E,
        ),
        MapMarkerModel(
          id: 'marker-4-8',
          rating: '4.8',
          markerLeftRatio: 242 / 390,
          markerTopRatio: 320 / 844,
          avatarLeftRatio: 243 / 390,
          avatarTopRatio: 288 / 844,
          avatarTintHex: 0xFFDEB98B,
        ),
      ],
    );
  }
}
