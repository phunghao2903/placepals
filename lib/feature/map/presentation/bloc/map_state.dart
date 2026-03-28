part of 'map_bloc.dart';

enum MapStatus { initial, loading, success, failure }

class MapState {
  final MapStatus status;
  final MapFeed? feed;
  final String query;
  final String selectedMarkerId;
  final bool isLayerSheetOpen;
  final bool showCurrentLocation;
  final String detailNote;
  final String? errorMessage;

  const MapState({
    this.status = MapStatus.initial,
    this.feed,
    this.query = '',
    this.selectedMarkerId = '',
    this.isLayerSheetOpen = false,
    this.showCurrentLocation = false,
    this.detailNote = '',
    this.errorMessage,
  });

  MapState copyWith({
    MapStatus? status,
    MapFeed? feed,
    String? query,
    String? selectedMarkerId,
    bool? isLayerSheetOpen,
    bool? showCurrentLocation,
    String? detailNote,
    String? errorMessage,
  }) {
    return MapState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      query: query ?? this.query,
      selectedMarkerId: selectedMarkerId ?? this.selectedMarkerId,
      isLayerSheetOpen: isLayerSheetOpen ?? this.isLayerSheetOpen,
      showCurrentLocation: showCurrentLocation ?? this.showCurrentLocation,
      detailNote: detailNote ?? this.detailNote,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
