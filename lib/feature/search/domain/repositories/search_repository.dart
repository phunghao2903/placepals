import '../entities/search_feed.dart';

abstract class SearchRepository {
  Future<SearchFeed> getSearchFeed();
}
