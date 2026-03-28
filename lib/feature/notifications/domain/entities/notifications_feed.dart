class NotificationsFeed {
  final String title;
  final String markAllReadLabel;
  final List<NotificationItem> items;

  const NotificationsFeed({
    required this.title,
    required this.markAllReadLabel,
    required this.items,
  });
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final String sectionLabel;
  final String type;
  final String leadingAssetPath;
  final bool isUnread;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.sectionLabel,
    required this.type,
    required this.leadingAssetPath,
    required this.isUnread,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? timeLabel,
    String? sectionLabel,
    String? type,
    String? leadingAssetPath,
    bool? isUnread,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      type: type ?? this.type,
      leadingAssetPath: leadingAssetPath ?? this.leadingAssetPath,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}
