import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/search_destination.dart';
import '../../domain/entities/search_filter.dart';
import '../../domain/entities/search_feed.dart';
import '../../domain/usecases/get_search_feed_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchFeedUseCase getSearchFeedUseCase;

  SearchBloc({required this.getSearchFeedUseCase})
    : super(const SearchState()) {
    on<SearchStarted>(_onStarted);
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchRecentTapped>(_onRecentTapped);
    on<SearchFilterSelected>(_onFilterSelected);
    on<SearchFavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onStarted(
    SearchStarted event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final feed = await getSearchFeedUseCase();
      emit(
        state.copyWith(
          status: SearchStatus.success,
          feed: feed,
          visibleDestinations: feed.destinations,
          filters: feed.filters,
          query: feed.initialQuery,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Unable to load search screen.',
        ),
      );
    }
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    final feed = state.feed;
    if (feed == null) return;
    final destinations = _filterDestinations(
      destinations: feed.destinations,
      query: event.query,
    );
    emit(state.copyWith(query: event.query, visibleDestinations: destinations));
  }

  void _onRecentTapped(SearchRecentTapped event, Emitter<SearchState> emit) {
    add(SearchQueryChanged(query: event.query));
  }

  void _onFilterSelected(
    SearchFilterSelected event,
    Emitter<SearchState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;
    final filters = state.filters
        .cast<SearchFilter>()
        .map((item) {
          return item.copyWith(isSelected: item.id == event.filterId);
        })
        .toList(growable: false);
    emit(state.copyWith(filters: filters));
  }

  void _onFavoriteToggled(
    SearchFavoriteToggled event,
    Emitter<SearchState> emit,
  ) {
    final updated = state.visibleDestinations
        .cast<SearchDestination>()
        .map((item) {
          if (item.id != event.destinationId) return item;
          return item.copyWith(
            isFavorite: !item.isFavorite,
            isLiked: !item.isFavorite,
          );
        })
        .toList(growable: false);
    emit(state.copyWith(visibleDestinations: updated));
  }

  List<SearchDestination> _filterDestinations({
    required List<SearchDestination> destinations,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return destinations;
    return destinations
        .where((item) {
          return item.title.toLowerCase().contains(normalizedQuery) ||
              item.subtitle.toLowerCase().contains(normalizedQuery);
        })
        .toList(growable: false);
  }
}
