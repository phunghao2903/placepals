import '../entities/savedlist_feed.dart';
import '../repositories/savedlist_repository.dart';

class GetSavedListFeedUseCase {
  final SavedListRepository repository;

  const GetSavedListFeedUseCase(this.repository);

  Future<SavedListFeed> call() {
    return repository.getSavedListFeed();
  }
}
