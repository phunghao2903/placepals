import 'package:get_it/get_it.dart';

import 'data/datasources/search_local_datasource.dart';
import 'data/repositories/search_repository_impl.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/usecases/get_search_feed_usecase.dart';
import 'presentation/bloc/search_bloc.dart';

void registerSearchDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<SearchLocalDataSource>(
      SearchLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(getIt<SearchLocalDataSource>()),
    )
    ..registerLazySingleton<GetSearchFeedUseCase>(
      () => GetSearchFeedUseCase(getIt<SearchRepository>()),
    )
    ..registerFactory<SearchBloc>(
      () => SearchBloc(getSearchFeedUseCase: getIt<GetSearchFeedUseCase>()),
    );
}
