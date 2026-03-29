part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class SearchStarted extends SearchEvent {
  const SearchStarted();
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged({required this.query});
}

class SearchRecentTapped extends SearchEvent {
  final String query;

  const SearchRecentTapped({required this.query});
}

class SearchFilterSelected extends SearchEvent {
  final String filterId;

  const SearchFilterSelected({required this.filterId});
}

class SearchFavoriteToggled extends SearchEvent {
  final String destinationId;

  const SearchFavoriteToggled({required this.destinationId});
}
