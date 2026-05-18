import 'appointment_feed.dart';

class AppointmentCreateInput {
  final String planName;
  final String dateLabel;
  final String timeLabel;
  final String description;
  final List<AppointmentInvitee> invitees;

  const AppointmentCreateInput({
    required this.planName,
    required this.dateLabel,
    required this.timeLabel,
    required this.description,
    required this.invitees,
  });
}
