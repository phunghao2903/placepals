import '../entities/appointment_create_input.dart';
import '../entities/appointment_feed.dart';

abstract class AppointmentRepository {
  Future<AppointmentFeed> getAppointmentFeed();

  Future<String> createAppointment(AppointmentCreateInput input);
}
