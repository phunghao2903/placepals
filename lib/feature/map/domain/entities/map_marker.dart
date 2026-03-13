class MapMarker {
  final String id;
  final String rating;
  final bool showMarker;
  final double markerLeftRatio;
  final double markerTopRatio;
  final double? avatarLeftRatio;
  final double? avatarTopRatio;
  final int? avatarTintHex;

  const MapMarker({
    required this.id,
    required this.rating,
    this.showMarker = true,
    required this.markerLeftRatio,
    required this.markerTopRatio,
    this.avatarLeftRatio,
    this.avatarTopRatio,
    this.avatarTintHex,
  });
}
