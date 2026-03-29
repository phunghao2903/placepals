import 'package:get_it/get_it.dart';

import 'data/datasources/place_details_local_datasource.dart';
import 'data/repositories/place_details_repository_impl.dart';
import 'domain/repositories/place_details_repository.dart';
import 'domain/usecases/get_place_details_feed_usecase.dart';
import 'presentation/bloc/place_details_bloc.dart';

void registerPlaceDetailsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<PlaceDetailsLocalDataSource>(
      PlaceDetailsLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<PlaceDetailsRepository>(
      () => PlaceDetailsRepositoryImpl(getIt<PlaceDetailsLocalDataSource>()),
    )
    ..registerLazySingleton<GetPlaceDetailsFeedUseCase>(
      () => GetPlaceDetailsFeedUseCase(getIt<PlaceDetailsRepository>()),
    )
    ..registerFactory<PlaceDetailsBloc>(
      () => PlaceDetailsBloc(
        getPlaceDetailsFeedUseCase: getIt<GetPlaceDetailsFeedUseCase>(),
      ),
    );
}
