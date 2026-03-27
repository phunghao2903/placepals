import '../../domain/entities/map_overlay_setting.dart';

class MapOverlaySettingModel {
  final String id;
  final String title;
  final String subtitle;
  final String iconKey;
  final bool isEnabled;
  final bool isHighlighted;

  const MapOverlaySettingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconKey,
    required this.isEnabled,
    this.isHighlighted = false,
  });

  MapOverlaySetting toEntity() {
    return MapOverlaySetting(
      id: id,
      title: title,
      subtitle: subtitle,
      iconKey: iconKey,
      isEnabled: isEnabled,
      isHighlighted: isHighlighted,
    );
  }
}
