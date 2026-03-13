import '../../domain/entities/map_feed.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/map_local_datasource.dart';

class MapRepositoryImpl implements MapRepository {
  final MapLocalDataSource localDataSource;

  const MapRepositoryImpl(this.localDataSource);

  @override
  Future<MapFeed> getMapFeed() async {
    final feed = await localDataSource.getMapFeed();
    return feed.toEntity();
  }
}
