part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationsStarted extends NotificationsEvent {
  const NotificationsStarted();
}

class NotificationsFilterSelected extends NotificationsEvent {
  final String filterId;

  const NotificationsFilterSelected({required this.filterId});
}

class NotificationsMarkAllReadRequested extends NotificationsEvent {
  const NotificationsMarkAllReadRequested();
}

class NotificationsItemMarkedAsRead extends NotificationsEvent {
  final String notificationId;

  const NotificationsItemMarkedAsRead({required this.notificationId});
}

class NotificationsItemTapped extends NotificationsEvent {
  final String notificationId;

  const NotificationsItemTapped({required this.notificationId});
}

class NotificationsNavigationHandled extends NotificationsEvent {
  const NotificationsNavigationHandled();
}
