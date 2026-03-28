part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationsStarted extends NotificationsEvent {
  const NotificationsStarted();
}

class NotificationsItemOpened extends NotificationsEvent {
  final String notificationId;

  const NotificationsItemOpened({
    required this.notificationId,
  });
}

class NotificationsMarkAllReadPressed extends NotificationsEvent {
  const NotificationsMarkAllReadPressed();
}

class NotificationsTabSelected extends NotificationsEvent {
  final NotificationsFilterTab tab;

  const NotificationsTabSelected({
    required this.tab,
  });
}
