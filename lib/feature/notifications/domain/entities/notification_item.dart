enum NotificationItemType {
  palRequest,
  sosAlert,
  placeSpotlight,
  locationVerified,
  taggedYou,
}

enum NotificationNavigationTarget { profile, map, sos }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final String sectionLabel;
  final NotificationItemType type;
  final NotificationNavigationTarget navigationTarget;
  final String? imagePath;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.sectionLabel,
    required this.type,
    required this.navigationTarget,
    required this.isRead,
    this.imagePath,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? timeLabel,
    String? sectionLabel,
    NotificationItemType? type,
    NotificationNavigationTarget? navigationTarget,
    String? imagePath,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      type: type ?? this.type,
      navigationTarget: navigationTarget ?? this.navigationTarget,
      imagePath: imagePath ?? this.imagePath,
      isRead: isRead ?? this.isRead,
    );
  }
}
