enum NotificationSection { today, yesterday }

extension NotificationSectionX on NotificationSection {
  String get label {
    switch (this) {
      case NotificationSection.today:
        return 'Today';
      case NotificationSection.yesterday:
        return 'Yesterday';
    }
  }
}

enum NotificationType {
  palRequest,
  sosAlert,
  recommendation,
  locationVerified,
  tagged,
}

enum NotificationDestination { profile, map, sos }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String relativeTime;
  final String? imagePath;
  final NotificationSection section;
  final NotificationType type;
  final NotificationDestination destination;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.relativeTime,
    required this.section,
    required this.type,
    required this.destination,
    required this.isRead,
    this.imagePath,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? relativeTime,
    String? imagePath,
    NotificationSection? section,
    NotificationType? type,
    NotificationDestination? destination,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      relativeTime: relativeTime ?? this.relativeTime,
      imagePath: imagePath ?? this.imagePath,
      section: section ?? this.section,
      type: type ?? this.type,
      destination: destination ?? this.destination,
      isRead: isRead ?? this.isRead,
    );
  }
}
