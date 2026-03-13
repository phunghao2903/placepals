import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/map_feed.dart';
import '../../domain/usecases/get_map_feed_usecase.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetMapFeedUseCase getMapFeedUseCase;

  MapBloc({
    required this.getMapFeedUseCase,
  }) : super(const MapState()) {
    on<MapStarted>(_onStarted);
    on<MapSearchChanged>(_onSearchChanged);
    on<MapFriendFilterSelected>(_onFriendFilterSelected);
    on<MapCategorySelected>(_onCategorySelected);
  }

  Future<void> _onStarted(MapStarted event, Emitter<MapState> emit) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      final feed = await getMapFeedUseCase();
      emit(
        state.copyWith(
          status: MapStatus.success,
          feed: feed,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MapStatus.failure,
          errorMessage: 'Unable to load map.',
        ),
      );
    }
  }

  void _onSearchChanged(
    MapSearchChanged event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        query: event.query,
      ),
    );
  }

  void _onFriendFilterSelected(
    MapFriendFilterSelected event,
    Emitter<MapState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedFilters = currentFeed.friendFilters
        .map(
          (filter) => filter.copyWith(isSelected: filter.id == event.filterId),
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(friendFilters: updatedFilters),
      ),
    );
  }

  void _onCategorySelected(
    MapCategorySelected event,
    Emitter<MapState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedCategories = currentFeed.categories
        .map(
          (category) => category.copyWith(
            isSelected: category.id == event.categoryId,
          ),
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(categories: updatedCategories),
      ),
    );
  }
}
