import '../../domain/entities/sos_feed.dart';

class SosFeedModel {
  final SosIntroContentModel intro;
  final SosHelpComposerModel helpComposer;
  final SosActiveAlertModel activeAlert;

  const SosFeedModel({
    required this.intro,
    required this.helpComposer,
    required this.activeAlert,
  });

  SosFeed toEntity() {
    return SosFeed(
      intro: intro.toEntity(),
      helpComposer: helpComposer.toEntity(),
      activeAlert: activeAlert.toEntity(),
    );
  }
}

class SosIntroContentModel {
  final String heroLabel;
  final String helperText;
  final String trailingActionLabel;

  const SosIntroContentModel({
    required this.heroLabel,
    required this.helperText,
    required this.trailingActionLabel,
  });

  SosIntroContent toEntity() {
    return SosIntroContent(
      heroLabel: heroLabel,
      helperText: helperText,
      trailingActionLabel: trailingActionLabel,
    );
  }
}

class SosHelpComposerModel {
  final String title;
  final String subtitle;
  final String descriptionLabel;
  final String descriptionHint;
  final String visibilityScopeLabel;
  final String sendHelpLabel;
  final List<SosEmergencyTypeModel> emergencyTypes;
  final List<SosVisibilityScopeModel> visibilityScopes;

  const SosHelpComposerModel({
    required this.title,
    required this.subtitle,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.visibilityScopeLabel,
    required this.sendHelpLabel,
    required this.emergencyTypes,
    required this.visibilityScopes,
  });

  SosHelpComposer toEntity() {
    return SosHelpComposer(
      title: title,
      subtitle: subtitle,
      descriptionLabel: descriptionLabel,
      descriptionHint: descriptionHint,
      visibilityScopeLabel: visibilityScopeLabel,
      sendHelpLabel: sendHelpLabel,
      emergencyTypes: emergencyTypes.map((item) => item.toEntity()).toList(),
      visibilityScopes:
          visibilityScopes.map((item) => item.toEntity()).toList(),
    );
  }
}

class SosActiveAlertModel {
  final String title;
  final String city;
  final String locationPrefix;
  final String locationName;
  final String respondersTitle;
  final String respondersEmptyLabel;
  final String markSafeLabel;
  final String holdToCancelLabel;
  final List<SosResponderModel> responders;

  const SosActiveAlertModel({
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

  SosActiveAlert toEntity() {
    return SosActiveAlert(
      title: title,
      city: city,
      locationPrefix: locationPrefix,
      locationName: locationName,
      respondersTitle: respondersTitle,
      respondersEmptyLabel: respondersEmptyLabel,
      markSafeLabel: markSafeLabel,
      holdToCancelLabel: holdToCancelLabel,
      responders: responders.map((item) => item.toEntity()).toList(),
    );
  }
}

class SosEmergencyTypeModel {
  final String id;
  final String title;
  final String iconKey;
  final bool isSelected;

  const SosEmergencyTypeModel({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.isSelected,
  });

  SosEmergencyType toEntity() {
    return SosEmergencyType(
      id: id,
      title: title,
      iconKey: iconKey,
      isSelected: isSelected,
    );
  }
}

class SosVisibilityScopeModel {
  final String id;
  final String label;
  final bool isSelected;

  const SosVisibilityScopeModel({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  SosVisibilityScope toEntity() {
    return SosVisibilityScope(
      id: id,
      label: label,
      isSelected: isSelected,
    );
  }
}

class SosResponderModel {
  final String id;
  final String name;
  final String details;
  final String etaLabel;
  final int avatarTintHex;

  const SosResponderModel({
    required this.id,
    required this.name,
    required this.details,
    required this.etaLabel,
    required this.avatarTintHex,
  });

  SosResponder toEntity() {
    return SosResponder(
      id: id,
      name: name,
      details: details,
      etaLabel: etaLabel,
      avatarTintHex: avatarTintHex,
    );
  }
}
