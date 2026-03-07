import '../../domain/entities/home_feed.dart';
import 'place_category_model.dart';
import 'place_item_model.dart';

class HomeFeedModel {
  final String city;
  final List<PlaceCategoryModel> categories;
  final List<PlaceItemModel> places;

  const HomeFeedModel({
    required this.city,
    required this.categories,
    required this.places,
  });

  HomeFeed toEntity() {
    return HomeFeed(
      city: city,
      categories: categories.map((item) => item.toEntity()).toList(),
      places: places.map((item) => item.toEntity()).toList(),
    );
  }
}
