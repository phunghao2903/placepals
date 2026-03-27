import 'notification_filter.dart';
import 'notification_item.dart';

class NotificationsFeed {
  final String title;
  final List<NotificationFilter> filters;
  final List<NotificationItem> items;

  const NotificationsFeed({
    required this.title,
    required this.filters,
    required this.items,
  });

  NotificationsFeed copyWith({
    String? title,
    List<NotificationFilter>? filters,
    List<NotificationItem>? items,
  }) {
    return NotificationsFeed(
      title: title ?? this.title,
      filters: filters ?? this.filters,
      items: items ?? this.items,
    );
  }
}
