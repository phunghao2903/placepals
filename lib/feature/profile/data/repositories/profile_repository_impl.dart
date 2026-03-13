import '../../domain/entities/profile_feed.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  const ProfileRepositoryImpl(this.localDataSource);

  @override
  Future<ProfileFeed> getProfileFeed() async {
    final model = await localDataSource.getProfileFeed();
    return model.toEntity();
  }
}
