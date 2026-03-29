import '../../domain/entities/location_feed.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  const LocationRepositoryImpl(this.localDataSource);

  @override
  Future<LocationFeed> getLocationFeed() {
    return localDataSource.getLocationFeed();
  }
}
