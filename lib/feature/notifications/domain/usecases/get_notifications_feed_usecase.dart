import '../entities/notifications_feed.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsFeedUseCase {
  final NotificationsRepository repository;

  const GetNotificationsFeedUseCase(this.repository);

  Future<NotificationsFeed> call() {
    return repository.getNotificationsFeed();
  }
}
