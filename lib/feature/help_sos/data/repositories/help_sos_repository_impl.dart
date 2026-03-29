import '../../domain/entities/help_sos_feed.dart';
import '../../domain/repositories/help_sos_repository.dart';
import '../datasources/help_sos_local_datasource.dart';

class HelpSosRepositoryImpl implements HelpSosRepository {
  final HelpSosLocalDataSource localDataSource;

  const HelpSosRepositoryImpl(this.localDataSource);

  @override
  Future<HelpSosFeed> getHelpSosFeed() async {
    final model = await localDataSource.getHelpSosFeed();
    return model.toEntity();
  }
}
