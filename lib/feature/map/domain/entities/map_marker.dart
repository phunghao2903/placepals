class MapMarker {
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

  const MapMarker({
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
}
