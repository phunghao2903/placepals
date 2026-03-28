import '../models/home_feed_model.dart';
import '../models/place_category_model.dart';
import '../models/place_item_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeFeedModel> getHomeFeed();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeFeedModel> getHomeFeed() async {
    return const HomeFeedModel(
      city: 'Da Nang',
      categories: <PlaceCategoryModel>[
        PlaceCategoryModel(id: 'all', label: 'All', isSelected: true),
        PlaceCategoryModel(id: 'coffee', label: 'Coffee', isSelected: false),
        PlaceCategoryModel(
          id: 'outdoors',
          label: 'Outdoors',
          isSelected: false,
        ),
        PlaceCategoryModel(id: 'bar', label: 'Bar', isSelected: false),
      ],
      places: <PlaceItemModel>[
        PlaceItemModel(
          id: 'bean-bloom-1',
          name: 'Bean & Bloom',
          category: 'Specialty Coffee',
          imagePath: 'assets/images/bean_bloom.png',
          distance: '0.4 mi',
          rating: 4.8,
          isOpen: true,
          isFavorite: false,
        ),
        PlaceItemModel(
          id: 'cafe-tan',
          name: 'Cafe Tan',
          category: 'Coffee & Brunch',
          imagePath: 'assets/images/cafe_tan.png',
          distance: '0.9 mi',
          rating: 4.7,
          isOpen: true,
          isFavorite: true,
        ),
        PlaceItemModel(
          id: 'korea-food',
          name: 'Korea Food',
          category: 'Korean Cuisine',
          imagePath: 'assets/images/korea_food.jpeg',
          distance: '1.2 mi',
          rating: 4.6,
          isOpen: true,
          isFavorite: false,
        ),
      ],
    );
  }
}
