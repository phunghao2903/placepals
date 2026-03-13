import '../../domain/entities/create_moment_feed.dart';
import '../../domain/repositories/create_moment_repository.dart';
import '../datasources/create_moment_local_datasource.dart';

class CreateMomentRepositoryImpl implements CreateMomentRepository {
  final CreateMomentLocalDataSource localDataSource;

  const CreateMomentRepositoryImpl(this.localDataSource);

  @override
  Future<CreateMomentFeed> getCreateMomentFeed() async {
    final feed = await localDataSource.getCreateMomentFeed();
    return feed.toEntity();
  }
}
