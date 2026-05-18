part of 'appointment_bloc.dart';

enum AppointmentStatus { initial, loading, success, failure }

class AppointmentState {
  static const Object _sentinel = Object();

  final AppointmentStatus status;
  final AppointmentFeed? feed;
  final String? errorMessage;
  final String? infoMessage;
  final bool isSubmitting;
  final String? createdAppointmentId;

  const AppointmentState({
    this.status = AppointmentStatus.initial,
    this.feed,
    this.errorMessage,
    this.infoMessage,
    this.isSubmitting = false,
    this.createdAppointmentId,
  });

  AppointmentState copyWith({
    AppointmentStatus? status,
    AppointmentFeed? feed,
    Object? errorMessage = _sentinel,
    Object? infoMessage = _sentinel,
    bool? isSubmitting,
    Object? createdAppointmentId = _sentinel,
  }) {
    return AppointmentState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      infoMessage: identical(infoMessage, _sentinel)
          ? this.infoMessage
          : infoMessage as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      createdAppointmentId: identical(createdAppointmentId, _sentinel)
          ? this.createdAppointmentId
          : createdAppointmentId as String?,
    );
  }
}
