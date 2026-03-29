part of 'notifications_bloc.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState {
  final NotificationsStatus status;
  final NotificationsFeed? feed;
  final List visibleNotifications;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.feed,
    this.visibleNotifications = const [],
    this.errorMessage,
  });

  NotificationsState copyWith({
    NotificationsStatus? status,
    NotificationsFeed? feed,
    List? visibleNotifications,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      visibleNotifications: visibleNotifications ?? this.visibleNotifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
