import '../../domain/entities/home_feed.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  const HomeRepositoryImpl(this.localDataSource);

  @override
  Future<HomeFeed> getHomeFeed() async {
    final feed = await localDataSource.getHomeFeed();
    return feed.toEntity();
  }
}
