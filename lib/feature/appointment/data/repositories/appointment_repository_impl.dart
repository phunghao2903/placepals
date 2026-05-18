import '../../domain/entities/appointment_create_input.dart';
import '../../domain/entities/appointment_feed.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_remote_datasource.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  const AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<AppointmentFeed> getAppointmentFeed() async {
    final feed = await remoteDataSource.getAppointmentFeed();
    return feed.toEntity();
  }

  @override
  Future<String> createAppointment(AppointmentCreateInput input) {
    return remoteDataSource.createAppointment(input);
  }
}
