import '../entities/appointment_feed.dart';
import '../repositories/appointment_repository.dart';

class GetAppointmentFeedUseCase {
  final AppointmentRepository repository;

  const GetAppointmentFeedUseCase(this.repository);

  Future<AppointmentFeed> call() {
    return repository.getAppointmentFeed();
  }
}
