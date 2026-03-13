part of 'map_bloc.dart';

enum MapStatus {
  initial,
  loading,
  success,
  failure,
}

class MapState {
  final MapStatus status;
  final MapFeed? feed;
  final String query;
  final String? errorMessage;

  const MapState({
    this.status = MapStatus.initial,
    this.feed,
    this.query = '',
    this.errorMessage,
  });

  MapState copyWith({
    MapStatus? status,
    MapFeed? feed,
    String? query,
    String? errorMessage,
  }) {
    return MapState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
