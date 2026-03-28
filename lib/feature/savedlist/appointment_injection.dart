import 'package:get_it/get_it.dart';

import 'data/datasources/savedlist_local_datasource.dart';
import 'data/repositories/savedlist_repository_impl.dart';
import 'domain/repositories/savedlist_repository.dart';
import 'domain/usecases/get_savedlist_feed_usecase.dart';
import 'presentation/bloc/savedlist_bloc.dart';

void registerSavedListDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<SavedListLocalDataSource>(
      SavedListLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<SavedListRepository>(
      () => SavedListRepositoryImpl(getIt<SavedListLocalDataSource>()),
    )
    ..registerLazySingleton<GetSavedListFeedUseCase>(
      () => GetSavedListFeedUseCase(getIt<SavedListRepository>()),
    )
    ..registerFactory<SavedListBloc>(
      () => SavedListBloc(
        getSavedListFeedUseCase: getIt<GetSavedListFeedUseCase>(),
      ),
    );
}
