part of 'notifications_bloc.dart';

enum NotificationsStatus {
  initial,
  loading,
  success,
  failure,
}

enum NotificationsFilterTab {
  all,
  unread,
  sosAlerts,
}

const Object _notificationsSentinel = Object();

class NotificationsState {
  final NotificationsStatus status;
  final NotificationsFeed? feed;
  final NotificationsFilterTab selectedTab;
  final String? openedNotificationId;
  final int openedNotificationTick;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.feed,
    this.selectedTab = NotificationsFilterTab.all,
    this.openedNotificationId,
    this.openedNotificationTick = 0,
    this.errorMessage,
  });

  List<NotificationItem> get visibleItems {
    final NotificationsFeed? currentFeed = feed;
    if (currentFeed == null) return const <NotificationItem>[];

    switch (selectedTab) {
      case NotificationsFilterTab.all:
        return currentFeed.items;
      case NotificationsFilterTab.unread:
        return currentFeed.items
            .where((item) => item.isUnread)
            .toList(growable: false);
      case NotificationsFilterTab.sosAlerts:
        return currentFeed.items
            .where((item) => item.type == 'help_sos')
            .toList(growable: false);
    }
  }

  NotificationsState copyWith({
    NotificationsStatus? status,
    NotificationsFeed? feed,
    NotificationsFilterTab? selectedTab,
    Object? openedNotificationId = _notificationsSentinel,
    int? openedNotificationTick,
    Object? errorMessage = _notificationsSentinel,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      selectedTab: selectedTab ?? this.selectedTab,
      openedNotificationId: identical(openedNotificationId, _notificationsSentinel)
          ? this.openedNotificationId
          : openedNotificationId as String?,
      openedNotificationTick: openedNotificationTick ?? this.openedNotificationTick,
      errorMessage: identical(errorMessage, _notificationsSentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
