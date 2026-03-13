import '../entities/search_feed.dart';
import '../repositories/search_repository.dart';

class GetSearchFeedUseCase {
  final SearchRepository repository;

  const GetSearchFeedUseCase(this.repository);

  Future<SearchFeed> call() {
    return repository.getSearchFeed();
  }
}
