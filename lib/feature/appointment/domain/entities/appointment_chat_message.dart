class AppointmentChatMessage {
  final String id;
  final String senderName;
  final String senderAvatarAssetPath;
  final String message;
  final bool isMine;
  final String? metaLabel;

  const AppointmentChatMessage({
    required this.id,
    required this.senderName,
    required this.senderAvatarAssetPath,
    required this.message,
    required this.isMine,
    this.metaLabel,
  });
}
