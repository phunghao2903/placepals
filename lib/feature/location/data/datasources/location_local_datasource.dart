import '../models/location_feed_model.dart';
import '../models/location_option_model.dart';

abstract class LocationLocalDataSource {
  Future<LocationFeedModel> getLocationFeed();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  @override
  Future<LocationFeedModel> getLocationFeed() async {
    return const LocationFeedModel(
      title: 'Location',
      searchHint: 'Search city, district, landmark...',
      currentLocationLabel: 'Use current location',
      popularSectionTitle: 'Popular Destinations',
      nearbySectionTitle: 'Nearby suggestions',
      locations: <LocationOptionModel>[
        LocationOptionModel(
          id: 'da-nang',
          title: 'Da Nang',
          subtitle: 'Hai Chau District, Vietnam',
          imagePath: 'assets/images/locations/danang.png',
          isPopular: true,
          isCurrentLocation: true,
        ),
        LocationOptionModel(
          id: 'ho-chi-minh-city',
          title: 'Ho Chi Minh',
          subtitle: 'Find your PlacePal in the city',
          imagePath: 'assets/images/locations/hcm.jpg',
          isPopular: true,
          isCurrentLocation: false,
        ),
        LocationOptionModel(
          id: 'ha-noi',
          title: 'Ha Noi',
          subtitle: 'Find your PlacePal in the city',
          imagePath: 'assets/images/locations/anh-ha-noi.jpg',
          isPopular: true,
          isCurrentLocation: false,
        ),
        LocationOptionModel(
          id: 'da-lat',
          title: 'Da Lat',
          subtitle: 'Find your PlacePal in the city',
          imagePath: 'assets/images/locations/du-lich-Da-Lat-ivivu1.jpg',
          isPopular: true,
          isCurrentLocation: false,
        ),
        LocationOptionModel(
          id: 'nha-trang',
          title: 'Nha Trang',
          subtitle: 'Find your PlacePal in the city',
          imagePath: 'assets/images/locations/thanh-pho-bien-nha-trang.jpg',
          isPopular: true,
          isCurrentLocation: false,
        ),
      ],
    );
  }
}
