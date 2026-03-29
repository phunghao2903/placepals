import '../../domain/entities/appointment_feed.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_local_datasource.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentLocalDataSource localDataSource;

  const AppointmentRepositoryImpl(this.localDataSource);

  @override
  Future<AppointmentFeed> getAppointmentFeed() async {
    final feed = await localDataSource.getAppointmentFeed();
    return feed.toEntity();
  }
}
