import '../entities/place_details_feed.dart';
import '../repositories/place_details_repository.dart';

class GetPlaceDetailsFeedUseCase {
  final PlaceDetailsRepository repository;

  const GetPlaceDetailsFeedUseCase(this.repository);

  Future<PlaceDetailsFeed> call(String placeId) {
    return repository.getPlaceDetailsFeed(placeId);
  }
}
