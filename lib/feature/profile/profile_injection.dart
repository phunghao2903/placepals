import 'package:get_it/get_it.dart';

import '../../core/firebase/firebase_auth_service.dart';
import 'data/datasources/current_user_profile_remote_datasource.dart';
import 'data/datasources/profile_local_datasource.dart';
import 'data/repositories/current_user_profile_repository_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/current_user_profile_repository.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_feed_usecase.dart';
import 'presentation/bloc/profile_bloc.dart';

void registerProfileDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<CurrentUserProfileRemoteDataSource>(
      () =>
          CurrentUserProfileRemoteDataSourceImpl(getIt<FirebaseAuthService>()),
    )
    ..registerLazySingleton<CurrentUserProfileRepository>(
      () => CurrentUserProfileRepositoryImpl(
        getIt<CurrentUserProfileRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      ProfileLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ProfileLocalDataSource>()),
    )
    ..registerLazySingleton<GetProfileFeedUseCase>(
      () => GetProfileFeedUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory<ProfileBloc>(
      () => ProfileBloc(getProfileFeedUseCase: getIt<GetProfileFeedUseCase>()),
    );
}
