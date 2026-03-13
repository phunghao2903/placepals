import '../../domain/entities/map_marker.dart';

class MapMarkerModel {
  final String id;
  final String rating;
  final bool showMarker;
  final double markerLeftRatio;
  final double markerTopRatio;
  final double? avatarLeftRatio;
  final double? avatarTopRatio;
  final int? avatarTintHex;

  const MapMarkerModel({
    required this.id,
    required this.rating,
    this.showMarker = true,
    required this.markerLeftRatio,
    required this.markerTopRatio,
    this.avatarLeftRatio,
    this.avatarTopRatio,
    this.avatarTintHex,
  });

  MapMarker toEntity() {
    return MapMarker(
      id: id,
      rating: rating,
      showMarker: showMarker,
      markerLeftRatio: markerLeftRatio,
      markerTopRatio: markerTopRatio,
      avatarLeftRatio: avatarLeftRatio,
      avatarTopRatio: avatarTopRatio,
      avatarTintHex: avatarTintHex,
    );
  }
}
