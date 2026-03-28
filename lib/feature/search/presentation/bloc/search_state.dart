part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final SearchStatus status;
  final SearchFeed? feed;
  final String query;
  final List visibleDestinations;
  final List filters;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.feed,
    this.query = '',
    this.visibleDestinations = const [],
    this.filters = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    SearchFeed? feed,
    String? query,
    List? visibleDestinations,
    List? filters,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      query: query ?? this.query,
      visibleDestinations: visibleDestinations ?? this.visibleDestinations,
      filters: filters ?? this.filters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
