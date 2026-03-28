import '../../domain/entities/notifications_feed.dart';

class NotificationsFeedModel {
  final String title;
  final String markAllReadLabel;
  final List<NotificationItemModel> items;

  const NotificationsFeedModel({
    required this.title,
    required this.markAllReadLabel,
    required this.items,
  });

  NotificationsFeed toEntity() {
    return NotificationsFeed(
      title: title,
      markAllReadLabel: markAllReadLabel,
      items: items.map((item) => item.toEntity()).toList(growable: false),
    );
  }
}

class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final String sectionLabel;
  final String type;
  final String leadingAssetPath;
  final bool isUnread;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.sectionLabel,
    required this.type,
    required this.leadingAssetPath,
    required this.isUnread,
  });

  NotificationItem toEntity() {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timeLabel: timeLabel,
      sectionLabel: sectionLabel,
      type: type,
      leadingAssetPath: leadingAssetPath,
      isUnread: isUnread,
    );
  }
}
