import 'package:get_it/get_it.dart';

import 'data/datasources/sos_local_datasource.dart';
import 'data/repositories/sos_repository_impl.dart';
import 'domain/repositories/sos_repository.dart';
import 'domain/usecases/get_sos_feed_usecase.dart';
import 'presentation/bloc/sos_bloc.dart';

void registerSosDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<SosLocalDataSource>(SosLocalDataSourceImpl.new)
    ..registerLazySingleton<SosRepository>(
      () => SosRepositoryImpl(getIt<SosLocalDataSource>()),
    )
    ..registerLazySingleton<GetSosFeedUseCase>(
      () => GetSosFeedUseCase(getIt<SosRepository>()),
    )
    ..registerFactory<SosBloc>(
      () => SosBloc(
        getSosFeedUseCase: getIt<GetSosFeedUseCase>(),
      ),
    );
}
