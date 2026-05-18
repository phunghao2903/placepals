import 'package:get_it/get_it.dart';

import '../../core/firebase/firebase_auth_service.dart';
import 'data/datasources/appointment_remote_datasource.dart';
import 'data/repositories/appointment_repository_impl.dart';
import 'domain/repositories/appointment_repository.dart';
import 'domain/usecases/create_appointment_usecase.dart';
import 'domain/usecases/get_appointment_feed_usecase.dart';
import 'presentation/bloc/appointment_bloc.dart';

void registerAppointmentDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(getIt<FirebaseAuthService>()),
    )
    ..registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(getIt<AppointmentRemoteDataSource>()),
    )
    ..registerLazySingleton<GetAppointmentFeedUseCase>(
      () => GetAppointmentFeedUseCase(getIt<AppointmentRepository>()),
    )
    ..registerLazySingleton<CreateAppointmentUseCase>(
      () => CreateAppointmentUseCase(getIt<AppointmentRepository>()),
    )
    ..registerFactory<AppointmentBloc>(
      () => AppointmentBloc(
        getAppointmentFeedUseCase: getIt<GetAppointmentFeedUseCase>(),
        createAppointmentUseCase: getIt<CreateAppointmentUseCase>(),
      ),
    );
}
