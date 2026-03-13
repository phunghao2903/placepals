import '../entities/create_moment_feed.dart';

abstract class CreateMomentRepository {
  Future<CreateMomentFeed> getCreateMomentFeed();
}
