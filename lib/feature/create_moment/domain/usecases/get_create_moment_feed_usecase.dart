import '../entities/create_moment_feed.dart';
import '../repositories/create_moment_repository.dart';

class GetCreateMomentFeedUseCase {
  final CreateMomentRepository repository;

  const GetCreateMomentFeedUseCase(this.repository);

  Future<CreateMomentFeed> call() {
    return repository.getCreateMomentFeed();
  }
}
