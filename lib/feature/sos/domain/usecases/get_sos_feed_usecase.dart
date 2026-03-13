import '../entities/sos_feed.dart';
import '../repositories/sos_repository.dart';

class GetSosFeedUseCase {
  final SosRepository repository;

  const GetSosFeedUseCase(this.repository);

  Future<SosFeed> call() {
    return repository.getSosFeed();
  }
}
