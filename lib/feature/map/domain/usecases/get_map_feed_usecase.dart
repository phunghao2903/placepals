import '../entities/map_feed.dart';
import '../repositories/map_repository.dart';

class GetMapFeedUseCase {
  final MapRepository repository;

  const GetMapFeedUseCase(this.repository);

  Future<MapFeed> call() {
    return repository.getMapFeed();
  }
}
