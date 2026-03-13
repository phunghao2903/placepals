import '../entities/profile_feed.dart';
import '../repositories/profile_repository.dart';

class GetProfileFeedUseCase {
  final ProfileRepository repository;

  const GetProfileFeedUseCase(this.repository);

  Future<ProfileFeed> call() {
    return repository.getProfileFeed();
  }
}
