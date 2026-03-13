import '../../domain/entities/search_feed.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;

  const SearchRepositoryImpl(this.localDataSource);

  @override
  Future<SearchFeed> getSearchFeed() async {
    final feed = await localDataSource.getSearchFeed();
    return feed.toEntity();
  }
}
