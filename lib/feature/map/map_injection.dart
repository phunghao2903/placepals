import 'package:get_it/get_it.dart';

import 'data/datasources/map_local_datasource.dart';
import 'data/repositories/map_repository_impl.dart';
import 'domain/repositories/map_repository.dart';
import 'domain/usecases/get_map_feed_usecase.dart';
import 'presentation/bloc/map_bloc.dart';

void registerMapDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<MapLocalDataSource>(MapLocalDataSourceImpl.new)
    ..registerLazySingleton<MapRepository>(
      () => MapRepositoryImpl(getIt<MapLocalDataSource>()),
    )
    ..registerLazySingleton<GetMapFeedUseCase>(
      () => GetMapFeedUseCase(getIt<MapRepository>()),
    )
    ..registerFactory<MapBloc>(
      () => MapBloc(getMapFeedUseCase: getIt<GetMapFeedUseCase>()),
    );
}
