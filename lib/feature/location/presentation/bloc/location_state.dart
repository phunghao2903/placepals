part of 'location_bloc.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState {
  final LocationStatus status;
  final LocationFeed? feed;
  final List<LocationOption> filteredLocations;
  final String query;
  final String? selectedLocationId;
  final String? errorMessage;

  const LocationState({
    this.status = LocationStatus.initial,
    this.feed,
    this.filteredLocations = const <LocationOption>[],
    this.query = '',
    this.selectedLocationId,
    this.errorMessage,
  });

  LocationState copyWith({
    LocationStatus? status,
    LocationFeed? feed,
    List<LocationOption>? filteredLocations,
    String? query,
    String? selectedLocationId,
    String? errorMessage,
  }) {
    return LocationState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      filteredLocations: filteredLocations ?? this.filteredLocations,
      query: query ?? this.query,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
