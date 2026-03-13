import '../entities/sos_feed.dart';

abstract class SosRepository {
  Future<SosFeed> getSosFeed();
}
