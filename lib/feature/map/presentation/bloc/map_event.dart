part of 'map_bloc.dart';

sealed class MapEvent {
  const MapEvent();
}

class MapStarted extends MapEvent {
  const MapStarted();
}

class MapSearchChanged extends MapEvent {
  final String query;

  const MapSearchChanged({required this.query});
}

class MapFriendFilterSelected extends MapEvent {
  final String filterId;

  const MapFriendFilterSelected({required this.filterId});
}

class MapCategorySelected extends MapEvent {
  final String categoryId;

  const MapCategorySelected({required this.categoryId});
}

class MapMarkerSelected extends MapEvent {
  final String markerId;

  const MapMarkerSelected({required this.markerId});
}

class MapPreviewClosed extends MapEvent {
  const MapPreviewClosed();
}

class MapCurrentLocationPressed extends MapEvent {
  const MapCurrentLocationPressed();
}

class MapLayerSheetOpened extends MapEvent {
  const MapLayerSheetOpened();
}

class MapLayerSheetClosed extends MapEvent {
  const MapLayerSheetClosed();
}

class MapStyleSelected extends MapEvent {
  final String styleId;

  const MapStyleSelected({required this.styleId});
}

class MapOverlayToggled extends MapEvent {
  final String overlayId;

  const MapOverlayToggled({required this.overlayId});
}

class MapPreviewSavedToggled extends MapEvent {
  const MapPreviewSavedToggled();
}

class MapDetailSavedToggled extends MapEvent {
  const MapDetailSavedToggled();
}

class MapDetailNoteChanged extends MapEvent {
  final String note;

  const MapDetailNoteChanged({required this.note});
}
