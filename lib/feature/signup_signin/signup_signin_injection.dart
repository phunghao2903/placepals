import 'package:get_it/get_it.dart';

import '../../core/firebase/firebase_auth_service.dart';
import '../../core/firebase/welcome_push_coordinator.dart';
import 'data/datasources/notifications_local_datasource.dart';
import 'data/datasources/signup_signin_remote_datasource.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'data/repositories/signup_signin_repository_impl.dart';
import 'domain/repositories/notifications_repository.dart';
import 'domain/repositories/signup_signin_repository.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/get_notifications_feed_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'presentation/bloc/notifications_bloc.dart';
import 'presentation/bloc/signup_signin_bloc.dart';

void registerSignupSigninDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<NotificationsLocalDataSource>(
      NotificationsLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<SignupSigninRemoteDataSource>(
      () => SignupSigninRemoteDataSourceImpl(getIt<FirebaseAuthService>()),
    )
    ..registerLazySingleton<SignupSigninRepository>(
      () => SignupSigninRepositoryImpl(getIt<SignupSigninRemoteDataSource>()),
    )
    ..registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(getIt<NotificationsLocalDataSource>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<SignupSigninRepository>()),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<SignupSigninRepository>()),
    )
    ..registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt<SignupSigninRepository>()),
    )
    ..registerLazySingleton<GetNotificationsFeedUseCase>(
      () => GetNotificationsFeedUseCase(getIt<NotificationsRepository>()),
    )
    ..registerFactory<SignupSigninBloc>(
      () => SignupSigninBloc(
        loginUseCase: getIt<LoginUseCase>(),
        registerUseCase: getIt<RegisterUseCase>(),
        forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
        welcomePushCoordinator: getIt<WelcomePushCoordinator>(),
      ),
    )
    ..registerFactory<NotificationsBloc>(
      () => NotificationsBloc(
        getNotificationsFeedUseCase: getIt<GetNotificationsFeedUseCase>(),
      ),
    );
}
