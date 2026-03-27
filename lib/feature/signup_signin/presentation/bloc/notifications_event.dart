part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationsStarted extends NotificationsEvent {
  const NotificationsStarted();
}

class NotificationsTabSelected extends NotificationsEvent {
  final String tabId;

  const NotificationsTabSelected({required this.tabId});
}

class NotificationsOpened extends NotificationsEvent {
  final String notificationId;

  const NotificationsOpened({required this.notificationId});
}

class NotificationsMarkAllReadRequested extends NotificationsEvent {
  const NotificationsMarkAllReadRequested();
}
