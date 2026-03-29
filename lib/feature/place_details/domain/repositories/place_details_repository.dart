import '../entities/place_details_feed.dart';

abstract class PlaceDetailsRepository {
  Future<PlaceDetailsFeed> getPlaceDetailsFeed(String placeId);
}
