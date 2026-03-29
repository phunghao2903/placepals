import '../entities/current_user_profile.dart';
import '../entities/update_current_user_profile_input.dart';

abstract class CurrentUserProfileRepository {
  Stream<CurrentUserProfile> watchCurrentUserProfile();

  Future<CurrentUserProfile> getCurrentUserProfile();

  Future<void> updateCurrentUserProfile(UpdateCurrentUserProfileInput input);
}
