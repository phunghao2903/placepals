part of 'map_bloc.dart';

sealed class MapEvent {
  const MapEvent();
}

class MapStarted extends MapEvent {
  const MapStarted();
}

class MapSearchChanged extends MapEvent {
  final String query;

  const MapSearchChanged({
    required this.query,
  });
}

class MapFriendFilterSelected extends MapEvent {
  final String filterId;

  const MapFriendFilterSelected({
    required this.filterId,
  });
}

class MapCategorySelected extends MapEvent {
  final String categoryId;

  const MapCategorySelected({
    required this.categoryId,
  });
}
