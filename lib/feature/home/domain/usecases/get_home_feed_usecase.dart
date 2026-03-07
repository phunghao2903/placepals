import '../entities/home_feed.dart';
import '../repositories/home_repository.dart';

class GetHomeFeedUseCase {
  final HomeRepository repository;

  const GetHomeFeedUseCase(this.repository);

  Future<HomeFeed> call() {
    return repository.getHomeFeed();
  }
}
