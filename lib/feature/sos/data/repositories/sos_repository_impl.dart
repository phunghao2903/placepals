import '../../domain/entities/sos_feed.dart';
import '../../domain/repositories/sos_repository.dart';
import '../datasources/sos_local_datasource.dart';

class SosRepositoryImpl implements SosRepository {
  final SosLocalDataSource localDataSource;

  const SosRepositoryImpl(this.localDataSource);

  @override
  Future<SosFeed> getSosFeed() async {
    final model = await localDataSource.getSosFeed();
    return model.toEntity();
  }
}
