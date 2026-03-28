import '../../domain/entities/notifications_feed.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_local_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource localDataSource;

  const NotificationsRepositoryImpl(this.localDataSource);

  @override
  Future<NotificationsFeed> getNotificationsFeed() async {
    final model = await localDataSource.getNotificationsFeed();
    return model.toEntity();
  }
}
