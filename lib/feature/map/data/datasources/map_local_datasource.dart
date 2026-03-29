import '../models/map_category_model.dart';
import '../models/map_feed_model.dart';
import '../models/map_friend_filter_model.dart';
import '../models/map_guide_model.dart';
import '../models/map_marker_model.dart';
import '../models/map_overlay_setting_model.dart';
import '../models/map_place_model.dart';
import '../models/map_search_place_model.dart';
import '../models/map_style_option_model.dart';
import '../../domain/entities/map_style_option.dart';

abstract class MapLocalDataSource {
  Future<MapFeedModel> getMapFeed();
}

class MapLocalDataSourceImpl implements MapLocalDataSource {
  @override
  Future<MapFeedModel> getMapFeed() async {
    return const MapFeedModel(
      searchHint: 'Seach friend or spots...',
      locationTitle: 'Add Location',
      locationSearchHint: 'Search for places, cities...',
      pickOnMapLabel: 'Pick on Map',
      nearbyPlacesTitle: 'Nearby Places',
      nearbyPlaces: <MapSearchPlaceModel>[
        MapSearchPlaceModel(
          id: 'the-coffee-house',
          title: 'The Coffee House',
          subtitle: '123 Main St, Downtown',
          distance: '0.2 mi',
          iconKey: 'local_cafe',
        ),
        MapSearchPlaceModel(
          id: 'central-park',
          title: 'Central Park',
          subtitle: 'Midtown West',
          distance: '0.5 mi',
          iconKey: 'park',
        ),
        MapSearchPlaceModel(
          id: 'bella-italia',
          title: 'Bella Italia',
          subtitle: '45 Napoli Ave',
          distance: '0.8 mi',
          iconKey: 'restaurant',
        ),
        MapSearchPlaceModel(
          id: 'rooftop-library',
          title: 'Rooftop Library',
          subtitle: '21 Nguyen Van Linh',
          distance: '1.1 mi',
          iconKey: 'local_library',
        ),
      ],
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
        MapCategoryModel(id: 'all', label: 'All', isSelected: true),
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
          canSelectPreview: false,
          avatarLeftRatio: 114 / 390,
          avatarTopRatio: 245 / 844,
          avatarImagePath: 'assets/images/profile.jpg',
        ),
        MapMarkerModel(
          id: 'marker-4-2-b',
          rating: '4.2',
          showMarker: false,
          markerLeftRatio: 122 / 390,
          markerTopRatio: 275 / 844,
          canSelectPreview: false,
          avatarLeftRatio: 136 / 390,
          avatarTopRatio: 245 / 844,
          avatarTintHex: 0xFFF4C27E,
          avatarImagePath: 'assets/images/profile.jpg',
        ),
        MapMarkerModel(
          id: 'marker-4-8',
          rating: '4.8',
          markerLeftRatio: 242 / 390,
          markerTopRatio: 320 / 844,
          canSelectPreview: true,
          avatarLeftRatio: 243 / 390,
          avatarTopRatio: 288 / 844,
          avatarTintHex: 0xFFDEB98B,
          avatarImagePath: 'assets/images/profile.jpg',
        ),
        MapMarkerModel(
          id: 'bottom-place-avatar',
          rating: '',
          showMarker: false,
          markerLeftRatio: 210 / 390,
          markerTopRatio: 575 / 844,
          avatarLeftRatio: 192 / 390,
          avatarTopRatio: 555 / 844,
          avatarImagePath: 'assets/images/bean_bloom.png',
        ),
      ],
      previewPlace: MapPlaceModel(
        id: 'starbuck-reserve',
        title: 'Starbuck Reserve Cafe',
        categoryLabel: 'Cafe',
        priceLabel: r'$$',
        rating: 4.8,
        reviewLabel: '1.2k reviews',
        distanceLabel: '0.4 mi away',
        availabilityLabel: 'Open Now',
        recommendationLabel: 'Rec. by Alex & 3 others',
        imagePath: 'assets/images/cafe_tan.png',
        heroImagePath: 'assets/images/cafe_tan.png',
        locationTitle: '3-13-14 Minamiaoyama',
        locationSubtitle: 'Minato City, Tokyo 107-0062',
        openStatusLabel: 'Open Now',
        closeStatusLabel: 'Closes 7 PM',
        hoursLabel: 'Full hours',
        noteHint:
            'What did you think of this place? Add a personal note for your trip...',
        isSaved: false,
        friendAvatarPaths: <String>[
          'assets/images/profile.jpg',
          'assets/images/profile.jpg',
          'assets/images/profile.jpg',
        ],
        relatedGuides: <MapGuideModel>[
          MapGuideModel(
            id: 'tokyo-coffee-scene',
            title: 'Tokyo Coffee Scene',
            subtitle: '12 locations',
            imagePath: 'assets/images/cafe_tan.png',
          ),
          MapGuideModel(
            id: 'hidden-gems-aoyama',
            title: 'Hidden Gems in Aoyama',
            subtitle: '8 locations',
            imagePath: 'assets/images/bean_bloom.png',
          ),
          MapGuideModel(
            id: 'best-latte-art',
            title: 'Best Latte Art 2024',
            subtitle: '15 locations',
            imagePath: 'assets/images/korea_food.jpeg',
          ),
        ],
      ),
      detailPlace: MapPlaceModel(
        id: 'blue-bottle-aoyama',
        title: 'Blue Bottle Coffee - Aoyama',
        categoryLabel: 'Cafe',
        priceLabel: r'$$',
        rating: 4.8,
        reviewLabel: '1.2k reviews',
        distanceLabel: '0.4 mi away',
        availabilityLabel: 'Open Now',
        recommendationLabel: 'Rec. by Alex & 3 others',
        imagePath: 'assets/images/cafe_tan.png',
        heroImagePath: 'assets/images/cafe_tan.png',
        locationTitle: '3-13-14 Minamiaoyama',
        locationSubtitle: 'Minato City, Tokyo 107-0062',
        openStatusLabel: 'Open Now',
        closeStatusLabel: 'Closes 7 PM',
        hoursLabel: 'Full hours',
        noteHint:
            'What did you think of this place? Add a personal note for your trip...',
        isSaved: false,
        friendAvatarPaths: <String>[
          'assets/images/profile.jpg',
          'assets/images/profile.jpg',
          'assets/images/profile.jpg',
        ],
        relatedGuides: <MapGuideModel>[
          MapGuideModel(
            id: 'tokyo-coffee-scene',
            title: 'Tokyo Coffee Scene',
            subtitle: '12 locations',
            imagePath: 'assets/images/cafe_tan.png',
          ),
          MapGuideModel(
            id: 'hidden-gems-aoyama',
            title: 'Hidden Gems in Aoyama',
            subtitle: '8 locations',
            imagePath: 'assets/images/bean_bloom.png',
          ),
          MapGuideModel(
            id: 'best-latte-art',
            title: 'Best Latte Art 2024',
            subtitle: '15 locations',
            imagePath: 'assets/images/korea_food.jpeg',
          ),
        ],
      ),
      styleOptions: <MapStyleOptionModel>[
        MapStyleOptionModel(
          id: 'standard',
          title: 'Standard',
          type: MapStyleType.standard,
          isSelected: true,
        ),
        MapStyleOptionModel(
          id: 'satellite',
          title: 'Satellite',
          type: MapStyleType.satellite,
          isSelected: false,
        ),
        MapStyleOptionModel(
          id: 'terrain',
          title: 'Terrain',
          type: MapStyleType.terrain,
          isSelected: false,
        ),
        MapStyleOptionModel(
          id: 'night-mode',
          title: 'Night Mode',
          type: MapStyleType.nightMode,
          isSelected: false,
        ),
      ],
      overlaySettings: <MapOverlaySettingModel>[
        MapOverlaySettingModel(
          id: 'friends',
          title: 'Friends',
          subtitle: 'Showing 12 active',
          iconKey: 'friends',
          isEnabled: true,
          isHighlighted: true,
        ),
        MapOverlaySettingModel(
          id: 'traffic',
          title: 'Traffic',
          subtitle: '',
          iconKey: 'traffic',
          isEnabled: false,
        ),
        MapOverlaySettingModel(
          id: 'biking',
          title: 'Biking',
          subtitle: '',
          iconKey: 'biking',
          isEnabled: false,
        ),
      ],
    );
  }
}
