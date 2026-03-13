import '../../domain/entities/sos_feed.dart';

class SosFeedModel {
  final String title;
  final String subtitle;
  final String descriptionLabel;
  final String descriptionHint;
  final String visibilityScopeLabel;
  final String sendHelpLabel;
  final List<SosEmergencyTypeModel> emergencyTypes;
  final List<SosVisibilityScopeModel> visibilityScopes;

  const SosFeedModel({
    required this.title,
    required this.subtitle,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.visibilityScopeLabel,
    required this.sendHelpLabel,
    required this.emergencyTypes,
    required this.visibilityScopes,
  });

  SosFeed toEntity() {
    return SosFeed(
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
