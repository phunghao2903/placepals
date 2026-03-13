import '../entities/map_feed.dart';

abstract class MapRepository {
  Future<MapFeed> getMapFeed();
}
