import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/map_feed.dart';
import '../../domain/entities/map_search_place.dart';
import '../../domain/usecases/get_map_feed_usecase.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetMapFeedUseCase getMapFeedUseCase;

  MapBloc({required this.getMapFeedUseCase}) : super(const MapState()) {
    on<MapStarted>(_onStarted);
    on<MapSearchChanged>(_onSearchChanged);
    on<MapLocationQueryChanged>(_onLocationQueryChanged);
    on<MapLocationSelected>(_onLocationSelected);
    on<MapFriendFilterSelected>(_onFriendFilterSelected);
    on<MapCategorySelected>(_onCategorySelected);
    on<MapMarkerSelected>(_onMarkerSelected);
    on<MapPreviewClosed>(_onPreviewClosed);
    on<MapCurrentLocationPressed>(_onCurrentLocationPressed);
    on<MapLayerSheetOpened>(_onLayerSheetOpened);
    on<MapLayerSheetClosed>(_onLayerSheetClosed);
    on<MapStyleSelected>(_onStyleSelected);
    on<MapOverlayToggled>(_onOverlayToggled);
    on<MapPreviewSavedToggled>(_onPreviewSavedToggled);
    on<MapDetailSavedToggled>(_onDetailSavedToggled);
    on<MapDetailNoteChanged>(_onDetailNoteChanged);
  }

  Future<void> _onStarted(MapStarted event, Emitter<MapState> emit) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      final feed = await getMapFeedUseCase();
      emit(
        state.copyWith(
          status: MapStatus.success,
          feed: feed,
          locationQuery: '',
          selectedLocationId: '',
          detailNote: '',
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

  void _onSearchChanged(MapSearchChanged event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        query: event.query,
        selectedMarkerId: '',
        isLayerSheetOpen: false,
      ),
    );
  }

  void _onLocationQueryChanged(
    MapLocationQueryChanged event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(locationQuery: event.query));
  }

  void _onLocationSelected(MapLocationSelected event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        query: event.place.title,
        locationQuery: event.place.title,
        selectedLocationId: event.place.id,
        selectedMarkerId: '',
        isLayerSheetOpen: false,
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
        selectedMarkerId: '',
      ),
    );
  }

  void _onCategorySelected(MapCategorySelected event, Emitter<MapState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedCategories = currentFeed.categories
        .map(
          (category) =>
              category.copyWith(isSelected: category.id == event.categoryId),
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(categories: updatedCategories),
        selectedMarkerId: '',
      ),
    );
  }

  void _onMarkerSelected(MapMarkerSelected event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        selectedMarkerId: event.markerId,
        isLayerSheetOpen: false,
        showCurrentLocation: false,
      ),
    );
  }

  void _onPreviewClosed(MapPreviewClosed event, Emitter<MapState> emit) {
    emit(state.copyWith(selectedMarkerId: ''));
  }

  void _onCurrentLocationPressed(
    MapCurrentLocationPressed event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        showCurrentLocation: !state.showCurrentLocation,
        selectedMarkerId: '',
        isLayerSheetOpen: false,
      ),
    );
  }

  void _onLayerSheetOpened(MapLayerSheetOpened event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        isLayerSheetOpen: true,
        selectedMarkerId: '',
        showCurrentLocation: false,
      ),
    );
  }

  void _onLayerSheetClosed(MapLayerSheetClosed event, Emitter<MapState> emit) {
    emit(state.copyWith(isLayerSheetOpen: false));
  }

  void _onStyleSelected(MapStyleSelected event, Emitter<MapState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedStyles = currentFeed.styleOptions
        .map((style) => style.copyWith(isSelected: style.id == event.styleId))
        .toList(growable: false);

    emit(
      state.copyWith(feed: currentFeed.copyWith(styleOptions: updatedStyles)),
    );
  }

  void _onOverlayToggled(MapOverlayToggled event, Emitter<MapState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedOverlays = currentFeed.overlaySettings
        .map(
          (overlay) => overlay.id == event.overlayId
              ? overlay.copyWith(isEnabled: !overlay.isEnabled)
              : overlay,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(overlaySettings: updatedOverlays),
      ),
    );
  }

  void _onPreviewSavedToggled(
    MapPreviewSavedToggled event,
    Emitter<MapState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(
          previewPlace: currentFeed.previewPlace.copyWith(
            isSaved: !currentFeed.previewPlace.isSaved,
          ),
        ),
      ),
    );
  }

  void _onDetailSavedToggled(
    MapDetailSavedToggled event,
    Emitter<MapState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(
          detailPlace: currentFeed.detailPlace.copyWith(
            isSaved: !currentFeed.detailPlace.isSaved,
          ),
        ),
      ),
    );
  }

  void _onDetailNoteChanged(
    MapDetailNoteChanged event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(detailNote: event.note));
  }
}
