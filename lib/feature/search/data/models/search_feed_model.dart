import '../../domain/entities/search_feed.dart';
import 'search_destination_model.dart';
import 'search_filter_model.dart';

class SearchFeedModel {
  final String title;
  final String searchHint;
  final String initialQuery;
  final List<SearchFilterModel> filters;
  final List<SearchDestinationModel> destinations;

  const SearchFeedModel({
    required this.title,
    required this.searchHint,
    required this.initialQuery,
    required this.filters,
    required this.destinations,
  });

  SearchFeed toEntity() {
    return SearchFeed(
      title: title,
      searchHint: searchHint,
      initialQuery: initialQuery,
      filters: filters.map((item) => item.toEntity()).toList(),
      destinations: destinations.map((item) => item.toEntity()).toList(),
    );
  }
}
