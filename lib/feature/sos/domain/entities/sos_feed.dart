class SosFeed {
  final String title;
  final String subtitle;
  final String descriptionLabel;
  final String descriptionHint;
  final String visibilityScopeLabel;
  final String sendHelpLabel;
  final List<SosEmergencyType> emergencyTypes;
  final List<SosVisibilityScope> visibilityScopes;

  const SosFeed({
    required this.title,
    required this.subtitle,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.visibilityScopeLabel,
    required this.sendHelpLabel,
    required this.emergencyTypes,
    required this.visibilityScopes,
  });

  SosFeed copyWith({
    String? title,
    String? subtitle,
    String? descriptionLabel,
    String? descriptionHint,
    String? visibilityScopeLabel,
    String? sendHelpLabel,
    List<SosEmergencyType>? emergencyTypes,
    List<SosVisibilityScope>? visibilityScopes,
  }) {
    return SosFeed(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      descriptionLabel: descriptionLabel ?? this.descriptionLabel,
      descriptionHint: descriptionHint ?? this.descriptionHint,
      visibilityScopeLabel: visibilityScopeLabel ?? this.visibilityScopeLabel,
      sendHelpLabel: sendHelpLabel ?? this.sendHelpLabel,
      emergencyTypes: emergencyTypes ?? this.emergencyTypes,
      visibilityScopes: visibilityScopes ?? this.visibilityScopes,
    );
  }
}

class SosEmergencyType {
  final String id;
  final String title;
  final String iconKey;
  final bool isSelected;

  const SosEmergencyType({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.isSelected,
  });

  SosEmergencyType copyWith({
    String? id,
    String? title,
    String? iconKey,
    bool? isSelected,
  }) {
    return SosEmergencyType(
      id: id ?? this.id,
      title: title ?? this.title,
      iconKey: iconKey ?? this.iconKey,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class SosVisibilityScope {
  final String id;
  final String label;
  final bool isSelected;

  const SosVisibilityScope({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  SosVisibilityScope copyWith({String? id, String? label, bool? isSelected}) {
    return SosVisibilityScope(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
