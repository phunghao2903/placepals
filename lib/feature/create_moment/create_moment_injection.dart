import 'package:get_it/get_it.dart';

import 'data/datasources/create_moment_local_datasource.dart';
import 'data/repositories/create_moment_repository_impl.dart';
import 'domain/repositories/create_moment_repository.dart';
import 'domain/usecases/get_create_moment_feed_usecase.dart';
import 'presentation/bloc/create_moment_bloc.dart';

void registerCreateMomentDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<CreateMomentLocalDataSource>(
      CreateMomentLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<CreateMomentRepository>(
      () => CreateMomentRepositoryImpl(getIt<CreateMomentLocalDataSource>()),
    )
    ..registerLazySingleton<GetCreateMomentFeedUseCase>(
      () => GetCreateMomentFeedUseCase(getIt<CreateMomentRepository>()),
    )
    ..registerFactory<CreateMomentBloc>(
      () => CreateMomentBloc(
        getCreateMomentFeedUseCase: getIt<GetCreateMomentFeedUseCase>(),
      ),
    );
}
