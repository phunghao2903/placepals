import 'package:get_it/get_it.dart';

import 'data/datasources/home_local_datasource.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_home_feed_usecase.dart';
import 'presentation/bloc/home_bloc.dart';

void registerHomeDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl.new)
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<HomeLocalDataSource>()),
    )
    ..registerLazySingleton<GetHomeFeedUseCase>(
      () => GetHomeFeedUseCase(getIt<HomeRepository>()),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(getHomeFeedUseCase: getIt<GetHomeFeedUseCase>()),
    );
}
