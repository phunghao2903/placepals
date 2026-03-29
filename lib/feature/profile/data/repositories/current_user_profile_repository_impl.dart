import '../../domain/entities/current_user_profile.dart';
import '../../domain/entities/update_current_user_profile_input.dart';
import '../../domain/repositories/current_user_profile_repository.dart';
import '../datasources/current_user_profile_remote_datasource.dart';

class CurrentUserProfileRepositoryImpl implements CurrentUserProfileRepository {
  final CurrentUserProfileRemoteDataSource remoteDataSource;

  const CurrentUserProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<CurrentUserProfile> getCurrentUserProfile() async {
    final model = await remoteDataSource.getCurrentUserProfile();
    return model.toEntity();
  }

  @override
  Future<void> updateCurrentUserProfile(UpdateCurrentUserProfileInput input) {
    return remoteDataSource.updateCurrentUserProfile(input);
  }

  @override
  Stream<CurrentUserProfile> watchCurrentUserProfile() {
    return remoteDataSource.watchCurrentUserProfile().map(
      (model) => model.toEntity(),
    );
  }
}
