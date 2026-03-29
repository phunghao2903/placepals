import '../../domain/entities/appointment_feed.dart';

class AppointmentInviteeModel {
  final String id;
  final String name;
  final String subtitle;
  final String avatarAssetPath;
  final bool isSelected;
  final bool isMuted;
  final bool showRemoveBadge;

  const AppointmentInviteeModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.avatarAssetPath,
    required this.isSelected,
    required this.isMuted,
    required this.showRemoveBadge,
  });

  AppointmentInvitee toEntity() {
    return AppointmentInvitee(
      id: id,
      name: name,
      subtitle: subtitle,
      avatarAssetPath: avatarAssetPath,
      isSelected: isSelected,
      isMuted: isMuted,
      showRemoveBadge: showRemoveBadge,
    );
  }
}
