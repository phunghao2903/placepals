import '../../domain/entities/notification_filter.dart';
import '../../domain/entities/notification_item.dart';
import '../models/notification_filter_model.dart';
import '../models/notification_item_model.dart';
import '../models/notifications_feed_model.dart';

abstract class NotificationsLocalDataSource {
  Future<NotificationsFeedModel> getNotificationsFeed();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<NotificationsFeedModel> getNotificationsFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));

    return const NotificationsFeedModel(
      title: 'Notifications',
      filters: <NotificationFilterModel>[
        NotificationFilterModel(
          id: 'all',
          label: 'All',
          type: NotificationFilterType.all,
          isSelected: true,
        ),
        NotificationFilterModel(
          id: 'unread',
          label: 'Unread',
          type: NotificationFilterType.unread,
          isSelected: false,
        ),
        NotificationFilterModel(
          id: 'sos-alerts',
          label: 'Sos Alerts',
          type: NotificationFilterType.sosAlerts,
          isSelected: false,
        ),
      ],
      items: <NotificationItemModel>[
        NotificationItemModel(
          id: 'new-pal-request-sarah',
          title: 'New Pal request from Sarah',
          message: 'Sarah wants to connect with you. She’s visiting your city!',
          timeLabel: '2m',
          sectionLabel: 'Today',
          type: NotificationItemType.palRequest,
          navigationTarget: NotificationNavigationTarget.profile,
          imagePath: 'assets/images/profile.jpg',
          isRead: false,
        ),
        NotificationItemModel(
          id: 'emergency-sos-alert',
          title: 'Emergency SOS Alert',
          message:
              'An SOS alert was triggered by a Pal Within 500m of your location.',
          timeLabel: '1h',
          sectionLabel: 'Today',
          type: NotificationItemType.sosAlert,
          navigationTarget: NotificationNavigationTarget.sos,
          isRead: false,
        ),
        NotificationItemModel(
          id: 'blue-cafe-spotlight',
          title: 'Check out ‘The Blue Café’',
          message:
              '3 Pal have visited this spot today. Check it out on the map',
          timeLabel: '4h',
          sectionLabel: 'Today',
          type: NotificationItemType.placeSpotlight,
          navigationTarget: NotificationNavigationTarget.map,
          imagePath: 'assets/images/bean_bloom.png',
          isRead: true,
        ),
        NotificationItemModel(
          id: 'location-verified',
          title: 'Location Verified',
          message:
              'Your check-in at central Park has been verified by the communication',
          timeLabel: '1d',
          sectionLabel: 'Yesterday',
          type: NotificationItemType.locationVerified,
          navigationTarget: NotificationNavigationTarget.map,
          isRead: false,
        ),
        NotificationItemModel(
          id: 'rose-tagged-you',
          title: 'Rose Tagged you',
          message: '“Great time exploring the hidden alleys todays!”',
          timeLabel: '1d',
          sectionLabel: 'Yesterday',
          type: NotificationItemType.taggedYou,
          navigationTarget: NotificationNavigationTarget.profile,
          imagePath: 'assets/images/profile.jpg',
          isRead: true,
        ),
      ],
    );
  }
}
