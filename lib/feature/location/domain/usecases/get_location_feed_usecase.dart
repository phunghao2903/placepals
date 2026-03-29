import '../entities/location_feed.dart';
import '../repositories/location_repository.dart';

class GetLocationFeedUseCase {
  final LocationRepository repository;

  const GetLocationFeedUseCase(this.repository);

  Future<LocationFeed> call() {
    return repository.getLocationFeed();
  }
}
