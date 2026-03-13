import '../models/search_destination_model.dart';
import '../models/search_filter_model.dart';
import '../models/search_feed_model.dart';

abstract class SearchLocalDataSource {
  Future<SearchFeedModel> getSearchFeed();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  @override
  Future<SearchFeedModel> getSearchFeed() async {
    return const SearchFeedModel(
      title: 'Search Home',
      searchHint: 'Search city, cafe, view...',
      initialQuery: 'Shushi',
      filters: <SearchFilterModel>[
        SearchFilterModel(
          id: 'top-rated',
          label: 'Top Rated',
          isSelected: false,
        ),
        SearchFilterModel(
          id: 'open-now',
          label: 'Open Now',
          isSelected: true,
        ),
        SearchFilterModel(
          id: 'price',
          label: 'Price',
          isSelected: false,
        ),
      ],
      destinations: <SearchDestinationModel>[
        SearchDestinationModel(
          id: 'salmon-house',
          title: 'Salmon House',
          subtitle: 'Japanese',
          imagePath: 'assets/images/korea_food.jpeg',
          rating: 4.8,
          categoryMeta: r'Japanese $$$ 0.2 mi',
          socialText: 'Pals here',
          socialAvatarCount: 2,
          isFavorite: false,
          isLiked: false,
        ),
        SearchDestinationModel(
          id: 'fresh-catch-sushi',
          title: 'Fresh Catch Sushi',
          subtitle: 'Japanese',
          imagePath: 'assets/images/cafe_tan.png',
          rating: 4.7,
          categoryMeta: r'Japanese $$$ 0.8 mi',
          socialText: 'Like visted',
          socialAvatarCount: 1,
          isFavorite: false,
          isLiked: false,
        ),
        SearchDestinationModel(
          id: 'ocean-blue-grill',
          title: 'Ocean Blue Grill',
          subtitle: 'Seafood',
          imagePath: 'assets/images/bean_bloom.png',
          rating: 4.5,
          categoryMeta: r'Seafood $$$ 1.2 mi',
          socialText: 'Like visted',
          socialAvatarCount: 1,
          isFavorite: true,
          isLiked: true,
        ),
      ],
    );
  }
}
