import '../entities/help_sos_feed.dart';

abstract class HelpSosRepository {
  Future<HelpSosFeed> getHelpSosFeed();
}
