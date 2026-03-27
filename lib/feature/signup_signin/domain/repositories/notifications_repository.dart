import '../entities/notifications_feed.dart';

abstract class NotificationsRepository {
  Future<NotificationsFeed> getNotificationsFeed();
}
