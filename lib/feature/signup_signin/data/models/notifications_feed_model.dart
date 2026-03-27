import '../../domain/entities/notifications_feed.dart';
import 'notification_filter_model.dart';
import 'notification_item_model.dart';

class NotificationsFeedModel {
  final String title;
  final List<NotificationFilterModel> filters;
  final List<NotificationItemModel> notifications;

  const NotificationsFeedModel({
    required this.title,
    required this.filters,
    required this.notifications,
  });

  NotificationsFeed toEntity() {
    return NotificationsFeed(
      title: title,
      filters: filters.map((item) => item.toEntity()).toList(growable: false),
      notifications: notifications
          .map((item) => item.toEntity())
          .toList(growable: false),
    );
  }
}
