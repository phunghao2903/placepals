import '../entities/profile_feed.dart';

abstract class ProfileRepository {
  Future<ProfileFeed> getProfileFeed();
}
