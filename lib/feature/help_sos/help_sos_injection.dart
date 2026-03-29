import 'package:get_it/get_it.dart';

import 'data/datasources/help_sos_local_datasource.dart';
import 'data/repositories/help_sos_repository_impl.dart';
import 'domain/repositories/help_sos_repository.dart';
import 'domain/usecases/get_help_sos_feed_usecase.dart';
import 'presentation/bloc/help_sos_bloc.dart';

void registerHelpSosDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<HelpSosLocalDataSource>(
      HelpSosLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<HelpSosRepository>(
      () => HelpSosRepositoryImpl(getIt<HelpSosLocalDataSource>()),
    )
    ..registerLazySingleton<GetHelpSosFeedUseCase>(
      () => GetHelpSosFeedUseCase(getIt<HelpSosRepository>()),
    )
    ..registerFactory<HelpSosBloc>(
      () => HelpSosBloc(
        getHelpSosFeedUseCase: getIt<GetHelpSosFeedUseCase>(),
      ),
    );
}
