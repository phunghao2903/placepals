part of 'appointment_bloc.dart';

sealed class AppointmentEvent {
  const AppointmentEvent();
}

class AppointmentStarted extends AppointmentEvent {
  const AppointmentStarted();
}

class AppointmentPlanNameChanged extends AppointmentEvent {
  final String value;

  const AppointmentPlanNameChanged({required this.value});
}

class AppointmentDescriptionChanged extends AppointmentEvent {
  final String value;

  const AppointmentDescriptionChanged({required this.value});
}

class AppointmentDateChanged extends AppointmentEvent {
  final String label;

  const AppointmentDateChanged({required this.label});
}

class AppointmentTimeChanged extends AppointmentEvent {
  final String label;

  const AppointmentTimeChanged({required this.label});
}

class AppointmentInviteTapped extends AppointmentEvent {
  const AppointmentInviteTapped();
}

class AppointmentInviteesUpdated extends AppointmentEvent {
  final List<AppointmentInvitee> invitees;

  const AppointmentInviteesUpdated({required this.invitees});
}

class AppointmentInviteeToggled extends AppointmentEvent {
  final String inviteeId;

  const AppointmentInviteeToggled({required this.inviteeId});
}

class AppointmentSubmitted extends AppointmentEvent {
  const AppointmentSubmitted();
}
