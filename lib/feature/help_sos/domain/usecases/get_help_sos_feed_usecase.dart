import '../entities/help_sos_feed.dart';
import '../repositories/help_sos_repository.dart';

class GetHelpSosFeedUseCase {
  final HelpSosRepository repository;

  const GetHelpSosFeedUseCase(this.repository);

  Future<HelpSosFeed> call() {
    return repository.getHelpSosFeed();
  }
}
