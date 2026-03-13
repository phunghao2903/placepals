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

  HomeFeed copyWith({
    String? city,
    List<PlaceCategory>? categories,
    List<PlaceItem>? places,
  }) {
    return HomeFeed(
      city: city ?? this.city,
      categories: categories ?? this.categories,
      places: places ?? this.places,
    );
  }
}
