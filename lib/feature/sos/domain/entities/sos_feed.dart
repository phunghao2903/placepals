class SosFeed {
  final SosIntroContent intro;
  final SosHelpComposer helpComposer;
  final SosActiveAlert activeAlert;

  const SosFeed({
    required this.intro,
    required this.helpComposer,
    required this.activeAlert,
  });

  SosFeed copyWith({
    SosIntroContent? intro,
    SosHelpComposer? helpComposer,
    SosActiveAlert? activeAlert,
  }) {
    return SosFeed(
      intro: intro ?? this.intro,
      helpComposer: helpComposer ?? this.helpComposer,
      activeAlert: activeAlert ?? this.activeAlert,
    );
  }
}

class SosIntroContent {
  final String heroLabel;
  final String helperText;
  final String trailingActionLabel;

  const SosIntroContent({
    required this.heroLabel,
    required this.helperText,
    required this.trailingActionLabel,
  });
}

class SosHelpComposer {
  final String title;
  final String subtitle;
  final String descriptionLabel;
  final String descriptionHint;
  final String visibilityScopeLabel;
  final String sendHelpLabel;
  final List<SosEmergencyType> emergencyTypes;
  final List<SosVisibilityScope> visibilityScopes;

  const SosHelpComposer({
    required this.title,
    required this.subtitle,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.visibilityScopeLabel,
    required this.sendHelpLabel,
    required this.emergencyTypes,
    required this.visibilityScopes,
  });

  SosHelpComposer copyWith({
    String? title,
    String? subtitle,
    String? descriptionLabel,
    String? descriptionHint,
    String? visibilityScopeLabel,
    String? sendHelpLabel,
    List<SosEmergencyType>? emergencyTypes,
    List<SosVisibilityScope>? visibilityScopes,
  }) {
    return SosHelpComposer(
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

class SosActiveAlert {
  final String title;
  final String city;
  final String locationPrefix;
  final String locationName;
  final String respondersTitle;
  final String respondersEmptyLabel;
  final String markSafeLabel;
  final String holdToCancelLabel;
  final List<SosResponder> responders;

  const SosActiveAlert({
    required this.title,
    required this.city,
    required this.locationPrefix,
    required this.locationName,
    required this.respondersTitle,
    required this.respondersEmptyLabel,
    required this.markSafeLabel,
    required this.holdToCancelLabel,
    required this.responders,
  });
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

  SosVisibilityScope copyWith({
    String? id,
    String? label,
    bool? isSelected,
  }) {
    return SosVisibilityScope(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class SosResponder {
  final String id;
  final String name;
  final String details;
  final String etaLabel;
  final int avatarTintHex;

  const SosResponder({
    required this.id,
    required this.name,
    required this.details,
    required this.etaLabel,
    required this.avatarTintHex,
  });
}
