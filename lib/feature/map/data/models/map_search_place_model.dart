import '../../domain/entities/map_search_place.dart';

class MapSearchPlaceModel {
  final String id;
  final String title;
  final String subtitle;
  final String distance;
  final String iconKey;

  const MapSearchPlaceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.iconKey,
  });

  MapSearchPlace toEntity() {
    return MapSearchPlace(
      id: id,
      title: title,
      subtitle: subtitle,
      distance: distance,
      iconKey: iconKey,
    );
  }
}
