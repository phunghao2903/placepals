import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/location_feed.dart';
import '../../domain/entities/location_option.dart';
import '../../domain/usecases/get_location_feed_usecase.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationFeedUseCase getLocationFeedUseCase;

  LocationBloc({required this.getLocationFeedUseCase})
    : super(const LocationState()) {
    on<LocationStarted>(_onStarted);
    on<LocationSearchChanged>(_onSearchChanged);
    on<LocationSelected>(_onSelected);
  }

  Future<void> _onStarted(
    LocationStarted event,
    Emitter<LocationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LocationStatus.loading,
        selectedLocationId: event.initialLocationId,
      ),
    );

    try {
      final feed = await getLocationFeedUseCase();
      emit(
        state.copyWith(
          status: LocationStatus.success,
          feed: feed,
          filteredLocations: _filterLocations(feed.locations, state.query),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: 'Unable to load locations.',
        ),
      );
    }
  }

  void _onSearchChanged(
    LocationSearchChanged event,
    Emitter<LocationState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;

    emit(
      state.copyWith(
        query: event.query,
        filteredLocations: _filterLocations(feed.locations, event.query),
      ),
    );
  }

  void _onSelected(LocationSelected event, Emitter<LocationState> emit) {
    emit(state.copyWith(selectedLocationId: event.locationId));
  }

  List<LocationOption> _filterLocations(
    List<LocationOption> locations,
    String query,
  ) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return locations;
    }

    return locations.where((location) {
      return location.title.toLowerCase().contains(normalized) ||
          location.subtitle.toLowerCase().contains(normalized);
    }).toList(growable: false);
  }
}
