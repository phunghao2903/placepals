import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/savedlist_feed.dart';
import '../../domain/usecases/get_savedlist_feed_usecase.dart';

part 'savedlist_event.dart';
part 'savedlist_state.dart';

class SavedListBloc extends Bloc<SavedListEvent, SavedListState> {
  final GetSavedListFeedUseCase getSavedListFeedUseCase;

  SavedListBloc({
    required this.getSavedListFeedUseCase,
  }) : super(const SavedListState()) {
    on<SavedListStarted>(_onStarted);
    on<SavedListTabChanged>(_onTabChanged);
    on<SavedListSearchChanged>(_onSearchChanged);
    on<SavedListWishlistToggled>(_onWishlistToggled);
    on<SavedListPlaceMarkedVisited>(_onPlaceMarkedVisited);
  }

  Future<void> _onStarted(
    SavedListStarted event,
    Emitter<SavedListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SavedListStatus.loading,
        activeTab: event.initialTab,
        errorMessage: null,
      ),
    );

    try {
      final feed = await getSavedListFeedUseCase();
      emit(
        state.copyWith(
          status: SavedListStatus.success,
          feed: feed,
          activeTab: event.initialTab,
          searchQuery: '',
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SavedListStatus.failure,
          errorMessage: 'Unable to load saved places.',
        ),
      );
    }
  }

  void _onTabChanged(
    SavedListTabChanged event,
    Emitter<SavedListState> emit,
  ) {
    emit(
      state.copyWith(
        activeTab: event.tab,
        searchQuery: '',
      ),
    );
  }

  void _onSearchChanged(
    SavedListSearchChanged event,
    Emitter<SavedListState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onWishlistToggled(
    SavedListWishlistToggled event,
    Emitter<SavedListState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) {
      return;
    }

    final updatedPlaces = currentFeed.wishlistPlaces
        .where((place) => place.id != event.placeId)
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(wishlistPlaces: updatedPlaces),
      ),
    );
  }

  void _onPlaceMarkedVisited(
    SavedListPlaceMarkedVisited event,
    Emitter<SavedListState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) {
      return;
    }

    final placeIndex = currentFeed.wishlistPlaces.indexWhere(
      (place) => place.id == event.placeId,
    );
    if (placeIndex < 0) {
      return;
    }

    final place = currentFeed.wishlistPlaces[placeIndex];
    final updatedWishlist = List<WishlistPlace>.from(currentFeed.wishlistPlaces)
      ..removeAt(placeIndex);

    final updatedTrips = <VisitedTrip>[
      VisitedTrip(
        id: 'visited-${place.id}',
        monthLabel: 'Today',
        title: place.name,
        subtitle: place.subtitle,
        placesCount: 1,
        imagePath: place.imagePath,
      ),
      ...currentFeed.visitedTrips,
    ];

    final updatedStats = currentFeed.visitedStats
        .map((stat) {
          if (stat.label.toLowerCase() != 'trips') {
            return stat;
          }
          final value = int.tryParse(stat.value) ?? 0;
          return stat.copyWith(value: '${value + 1}');
        })
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(
          wishlistPlaces: updatedWishlist,
          visitedTrips: updatedTrips,
          visitedStats: updatedStats,
        ),
      ),
    );
  }
}
