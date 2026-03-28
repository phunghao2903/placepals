import '../../domain/entities/map_marker.dart';

class MapMarkerModel {
  final String id;
  final String rating;
  final bool showMarker;
  final double markerLeftRatio;
  final double markerTopRatio;
  final bool canSelectPreview;
  final double? avatarLeftRatio;
  final double? avatarTopRatio;
  final int? avatarTintHex;
  final String? avatarImagePath;

  const MapMarkerModel({
    required this.id,
    required this.rating,
    this.showMarker = true,
    required this.markerLeftRatio,
    required this.markerTopRatio,
    this.canSelectPreview = false,
    this.avatarLeftRatio,
    this.avatarTopRatio,
    this.avatarTintHex,
    this.avatarImagePath,
  });

  MapMarker toEntity() {
    return MapMarker(
      id: id,
      rating: rating,
      showMarker: showMarker,
      markerLeftRatio: markerLeftRatio,
      markerTopRatio: markerTopRatio,
      canSelectPreview: canSelectPreview,
      avatarLeftRatio: avatarLeftRatio,
      avatarTopRatio: avatarTopRatio,
      avatarTintHex: avatarTintHex,
      avatarImagePath: avatarImagePath,
    );
  }
}
