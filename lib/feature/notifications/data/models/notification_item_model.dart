import '../../domain/entities/notification_item.dart';

class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final String sectionLabel;
  final NotificationItemType type;
  final NotificationNavigationTarget navigationTarget;
  final String? imagePath;
  final bool isRead;

  const NotificationItemModel({
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

  NotificationItem toEntity() {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timeLabel: timeLabel,
      sectionLabel: sectionLabel,
      type: type,
      navigationTarget: navigationTarget,
      imagePath: imagePath,
      isRead: isRead,
    );
  }
}
