import '../entities/appointment_feed.dart';

abstract class AppointmentRepository {
  Future<AppointmentFeed> getAppointmentFeed();
}
