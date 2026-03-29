import '../entities/savedlist_feed.dart';

abstract class SavedListRepository {
  Future<SavedListFeed> getSavedListFeed();
}
