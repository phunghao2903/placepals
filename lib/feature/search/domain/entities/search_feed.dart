import 'search_destination.dart';
import 'search_filter.dart';

class SearchFeed {
  final String title;
  final String searchHint;
  final String initialQuery;
  final List<SearchFilter> filters;
  final List<SearchDestination> destinations;

  const SearchFeed({
    required this.title,
    required this.searchHint,
    required this.initialQuery,
    required this.filters,
    required this.destinations,
  });
}
