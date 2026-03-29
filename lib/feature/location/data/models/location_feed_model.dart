import '../../domain/entities/location_feed.dart';
import 'location_option_model.dart';

class LocationFeedModel extends LocationFeed {
  const LocationFeedModel({
    required super.title,
    required super.searchHint,
    required super.currentLocationLabel,
    required super.popularSectionTitle,
    required super.nearbySectionTitle,
    required List<LocationOptionModel> super.locations,
  });
}
