import 'notification_filter.dart';
import 'notification_item.dart';

class NotificationsFeed {
  final String title;
  final List<NotificationFilter> filters;
  final List<NotificationItem> notifications;

  const NotificationsFeed({
    required this.title,
    required this.filters,
    required this.notifications,
  });

  NotificationsFeed copyWith({
    String? title,
    List<NotificationFilter>? filters,
    List<NotificationItem>? notifications,
  }) {
    return NotificationsFeed(
      title: title ?? this.title,
      filters: filters ?? this.filters,
      notifications: notifications ?? this.notifications,
    );
  }
}
