import 'location_option.dart';

class LocationFeed {
  final String title;
  final String searchHint;
  final String currentLocationLabel;
  final String popularSectionTitle;
  final String nearbySectionTitle;
  final List<LocationOption> locations;

  const LocationFeed({
    required this.title,
    required this.searchHint,
    required this.currentLocationLabel,
    required this.popularSectionTitle,
    required this.nearbySectionTitle,
    required this.locations,
  });
}
