import 'place_category.dart';
import 'place_item.dart';

class HomeFeed {
  final String city;
  final List<PlaceCategory> categories;
  final List<PlaceItem> places;

  const HomeFeed({
    required this.city,
    required this.categories,
    required this.places,
  });
}
