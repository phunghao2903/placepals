import 'package:get_it/get_it.dart';

import 'data/datasources/location_local_datasource.dart';
import 'data/repositories/location_repository_impl.dart';
import 'domain/repositories/location_repository.dart';
import 'domain/usecases/get_location_feed_usecase.dart';
import 'presentation/bloc/location_bloc.dart';

void registerLocationDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<LocationLocalDataSource>(
      LocationLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(getIt<LocationLocalDataSource>()),
    )
    ..registerLazySingleton<GetLocationFeedUseCase>(
      () => GetLocationFeedUseCase(getIt<LocationRepository>()),
    )
    ..registerFactory<LocationBloc>(
      () => LocationBloc(
        getLocationFeedUseCase: getIt<GetLocationFeedUseCase>(),
      ),
    );
}
