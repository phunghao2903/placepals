import '../models/notifications_feed_model.dart';

abstract class NotificationsLocalDataSource {
  Future<NotificationsFeedModel> getNotificationsFeed();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<NotificationsFeedModel> getNotificationsFeed() async {
    return const NotificationsFeedModel(
      title: 'Notifications',
      markAllReadLabel: 'Mark all as read',
      items: <NotificationItemModel>[
        NotificationItemModel(
          id: 'pal-request-1',
          title: 'New Pal request from Sarah',
          message: "Sarah wants to connect with you.\nShe's visiting your city!",
          timeLabel: '2m',
          sectionLabel: 'Today',
          type: 'general',
          leadingAssetPath: 'assets/images/profile.jpg',
          isUnread: true,
        ),
        NotificationItemModel(
          id: 'help-sos-1',
          title: 'Emergency SOS Alert',
          message:
              'An SOS alert was triggered by a Pal\nwithin 500m of your location.',
          timeLabel: '1h',
          sectionLabel: 'Today',
          type: 'help_sos',
          leadingAssetPath: '',
          isUnread: true,
        ),
        NotificationItemModel(
          id: 'spot-1',
          title: "Check out 'The Blue Cafe'",
          message:
              '3 Pals have visited this spot today.\nCheck it out on the map!',
          timeLabel: '4h',
          sectionLabel: 'Today',
          type: 'general',
          leadingAssetPath: 'assets/images/bean_bloom.png',
          isUnread: false,
        ),
        NotificationItemModel(
          id: 'verified-1',
          title: 'Location Verified',
          message: 'Your latest place check-in has been approved.',
          timeLabel: '1d',
          sectionLabel: 'Yesterday',
          type: 'general',
          leadingAssetPath: 'assets/images/cafe_tan.png',
          isUnread: false,
        ),
      ],
    );
  }
}
