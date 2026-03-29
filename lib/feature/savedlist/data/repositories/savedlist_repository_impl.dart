import '../../domain/entities/savedlist_feed.dart';
import '../../domain/repositories/savedlist_repository.dart';
import '../datasources/savedlist_local_datasource.dart';

class SavedListRepositoryImpl implements SavedListRepository {
  final SavedListLocalDataSource localDataSource;

  const SavedListRepositoryImpl(this.localDataSource);

  @override
  Future<SavedListFeed> getSavedListFeed() async {
    final feed = await localDataSource.getSavedListFeed();
    return feed.toEntity();
  }
}
