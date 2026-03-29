class MapOverlaySetting {
  final String id;
  final String title;
  final String subtitle;
  final String iconKey;
  final bool isEnabled;
  final bool isHighlighted;

  const MapOverlaySetting({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconKey,
    required this.isEnabled,
    this.isHighlighted = false,
  });

  MapOverlaySetting copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? iconKey,
    bool? isEnabled,
    bool? isHighlighted,
  }) {
    return MapOverlaySetting(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconKey: iconKey ?? this.iconKey,
      isEnabled: isEnabled ?? this.isEnabled,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}
