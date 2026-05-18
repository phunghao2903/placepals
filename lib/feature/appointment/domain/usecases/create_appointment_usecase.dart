import '../entities/appointment_create_input.dart';
import '../repositories/appointment_repository.dart';

class CreateAppointmentUseCase {
  final AppointmentRepository _repository;

  const CreateAppointmentUseCase(this._repository);

  Future<String> call(AppointmentCreateInput input) {
    return _repository.createAppointment(input);
  }
}
