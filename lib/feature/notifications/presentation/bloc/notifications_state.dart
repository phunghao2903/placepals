part of 'notifications_bloc.dart';

const Object _notificationsStateUnset = Object();

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState {
  final NotificationsStatus status;
  final NotificationsFeed? feed;
  final List<NotificationFilter> filters;
  final List<NotificationItem> visibleItems;
  final String activeFilterId;
  final String? errorMessage;
  final NotificationNavigationTarget? pendingNavigationTarget;
  final String? pendingNotificationId;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.feed,
    this.filters = const <NotificationFilter>[],
    this.visibleItems = const <NotificationItem>[],
    this.activeFilterId = 'all',
    this.errorMessage,
    this.pendingNavigationTarget,
    this.pendingNotificationId,
  });

  bool get hasUnread =>
      feed?.items.any((item) => item.isRead == false) ?? false;

  NotificationsState copyWith({
    NotificationsStatus? status,
    NotificationsFeed? feed,
    List<NotificationFilter>? filters,
    List<NotificationItem>? visibleItems,
    String? activeFilterId,
    Object? errorMessage = _notificationsStateUnset,
    Object? pendingNavigationTarget = _notificationsStateUnset,
    Object? pendingNotificationId = _notificationsStateUnset,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      filters: filters ?? this.filters,
      visibleItems: visibleItems ?? this.visibleItems,
      activeFilterId: activeFilterId ?? this.activeFilterId,
      errorMessage: identical(errorMessage, _notificationsStateUnset)
          ? this.errorMessage
          : errorMessage as String?,
      pendingNavigationTarget:
          identical(pendingNavigationTarget, _notificationsStateUnset)
          ? this.pendingNavigationTarget
          : pendingNavigationTarget as NotificationNavigationTarget?,
      pendingNotificationId:
          identical(pendingNotificationId, _notificationsStateUnset)
          ? this.pendingNotificationId
          : pendingNotificationId as String?,
    );
  }
}
