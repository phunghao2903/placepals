import 'package:get_it/get_it.dart';

import 'data/datasources/appointment_local_datasource.dart';
import 'data/repositories/appointment_repository_impl.dart';
import 'domain/repositories/appointment_repository.dart';
import 'domain/usecases/get_appointment_feed_usecase.dart';
import 'presentation/bloc/appointment_bloc.dart';

void registerAppointmentDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<AppointmentLocalDataSource>(
      AppointmentLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(getIt<AppointmentLocalDataSource>()),
    )
    ..registerLazySingleton<GetAppointmentFeedUseCase>(
      () => GetAppointmentFeedUseCase(getIt<AppointmentRepository>()),
    )
    ..registerFactory<AppointmentBloc>(
      () => AppointmentBloc(
        getAppointmentFeedUseCase: getIt<GetAppointmentFeedUseCase>(),
      ),
    );
}
