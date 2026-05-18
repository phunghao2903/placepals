class AppointmentFeed {
  final String title;
  final String planNameLabel;
  final String planNameHint;
  final String planName;
  final String whenLabel;
  final String dateLabel;
  final String timeLabel;
  final String guestsLabel;
  final String descriptionLabel;
  final String descriptionHint;
  final String description;
  final String ctaLabel;
  final List<AppointmentInvitee> invitees;

  const AppointmentFeed({
    required this.title,
    required this.planNameLabel,
    required this.planNameHint,
    required this.planName,
    required this.whenLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.guestsLabel,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.description,
    required this.ctaLabel,
    required this.invitees,
  });

  int get selectedCount =>
      invitees.where((invitee) => invitee.isSelected).length;

  AppointmentFeed copyWith({
    String? title,
    String? planNameLabel,
    String? planNameHint,
    String? planName,
    String? whenLabel,
    String? dateLabel,
    String? timeLabel,
    String? guestsLabel,
    String? descriptionLabel,
    String? descriptionHint,
    String? description,
    String? ctaLabel,
    List<AppointmentInvitee>? invitees,
  }) {
    return AppointmentFeed(
      title: title ?? this.title,
      planNameLabel: planNameLabel ?? this.planNameLabel,
      planNameHint: planNameHint ?? this.planNameHint,
      planName: planName ?? this.planName,
      whenLabel: whenLabel ?? this.whenLabel,
      dateLabel: dateLabel ?? this.dateLabel,
      timeLabel: timeLabel ?? this.timeLabel,
      guestsLabel: guestsLabel ?? this.guestsLabel,
      descriptionLabel: descriptionLabel ?? this.descriptionLabel,
      descriptionHint: descriptionHint ?? this.descriptionHint,
      description: description ?? this.description,
      ctaLabel: ctaLabel ?? this.ctaLabel,
      invitees: invitees ?? this.invitees,
    );
  }
}

class AppointmentInvitee {
  final String id;
  final String name;
  final String subtitle;
  final String avatarAssetPath;
  final bool isSelected;
  final bool isMuted;
  final bool showRemoveBadge;

  const AppointmentInvitee({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.avatarAssetPath,
    required this.isSelected,
    required this.isMuted,
    required this.showRemoveBadge,
  });

  bool get hasAvatar => avatarAssetPath.trim().isNotEmpty;

  bool get usesNetworkAvatar {
    final normalized = avatarAssetPath.trim().toLowerCase();
    return normalized.startsWith('http://') ||
        normalized.startsWith('https://');
  }

  AppointmentInvitee copyWith({
    String? id,
    String? name,
    String? subtitle,
    String? avatarAssetPath,
    bool? isSelected,
    bool? isMuted,
    bool? showRemoveBadge,
  }) {
    return AppointmentInvitee(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
      isSelected: isSelected ?? this.isSelected,
      isMuted: isMuted ?? this.isMuted,
      showRemoveBadge: showRemoveBadge ?? this.showRemoveBadge,
    );
  }
}
