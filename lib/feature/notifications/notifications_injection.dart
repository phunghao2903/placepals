import 'package:get_it/get_it.dart';

import 'data/datasources/notifications_local_datasource.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'domain/repositories/notifications_repository.dart';
import 'domain/usecases/get_notifications_feed_usecase.dart';
import 'presentation/bloc/notifications_bloc.dart';

void registerNotificationsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<NotificationsLocalDataSource>(
      NotificationsLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(getIt<NotificationsLocalDataSource>()),
    )
    ..registerLazySingleton<GetNotificationsFeedUseCase>(
      () => GetNotificationsFeedUseCase(getIt<NotificationsRepository>()),
    )
    ..registerFactory<NotificationsBloc>(
      () => NotificationsBloc(
        getNotificationsFeedUseCase: getIt<GetNotificationsFeedUseCase>(),
      ),
    );
}
