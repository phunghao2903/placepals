import '../models/notification_filter_model.dart';
import '../models/notification_item_model.dart';
import '../models/notifications_feed_model.dart';

abstract class NotificationsLocalDataSource {
  Future<NotificationsFeedModel> getNotificationsFeed();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<NotificationsFeedModel> getNotificationsFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return const NotificationsFeedModel(
      title: 'Notifications',
      filters: <NotificationFilterModel>[
        NotificationFilterModel(id: 'all', label: 'All', isSelected: true),
        NotificationFilterModel(
          id: 'unread',
          label: 'Unread',
          isSelected: false,
        ),
        NotificationFilterModel(
          id: 'sos',
          label: 'Sos Alerts',
          isSelected: false,
        ),
      ],
      notifications: <NotificationItemModel>[
        NotificationItemModel(
          id: 'new-pal-request',
          title: 'New Pal request from Sarah',
          message: 'Sarah wants to connect with you. She’s visiting your city!',
          relativeTime: '2m',
          imagePath: 'assets/images/profile.jpg',
          section: 'today',
          type: 'palRequest',
          destination: 'profile',
          isRead: false,
        ),
        NotificationItemModel(
          id: 'emergency-sos-alert',
          title: 'Emergency SOS Alert',
          message:
              'An SOS alert was triggered by a Pal Within 500m of your location.',
          relativeTime: '1h',
          section: 'today',
          type: 'sosAlert',
          destination: 'sos',
          isRead: false,
        ),
        NotificationItemModel(
          id: 'blue-cafe-recommendation',
          title: 'Check out ‘The Blue Café’',
          message:
              '3 Pal have visited this spot today. Check it out on the map',
          relativeTime: '4h',
          imagePath: 'assets/images/cafe_tan.png',
          section: 'today',
          type: 'recommendation',
          destination: 'map',
          isRead: true,
        ),
        NotificationItemModel(
          id: 'location-verified',
          title: 'Location Verified',
          message:
              'Your check-in at central Park has been verified by the communication',
          relativeTime: '1d',
          section: 'yesterday',
          type: 'locationVerified',
          destination: 'map',
          isRead: true,
        ),
        NotificationItemModel(
          id: 'rose-tagged-you',
          title: 'Rose Tagged you',
          message: '“Great time exploring the hidden alleys todays!”',
          relativeTime: '1d',
          imagePath: 'assets/images/profile.jpg',
          section: 'yesterday',
          type: 'tagged',
          destination: 'profile',
          isRead: true,
        ),
      ],
    );
  }
}
