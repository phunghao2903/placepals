import '../entities/location_feed.dart';

abstract class LocationRepository {
  Future<LocationFeed> getLocationFeed();
}
