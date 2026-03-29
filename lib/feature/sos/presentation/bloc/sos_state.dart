part of 'sos_bloc.dart';

enum SosStatus {
  initial,
  loading,
  success,
  failure,
}

enum SosViewStep {
  intro,
  helpComposer,
  activeAlert,
}

const Object _sosSentinel = Object();

class SosState {
  final SosStatus status;
  final SosFeed? feed;
  final SosViewStep viewStep;
  final String description;
  final String? errorMessage;
  final bool isSendingAlert;
  final bool showActiveResponders;

  const SosState({
    this.status = SosStatus.initial,
    this.feed,
    this.viewStep = SosViewStep.intro,
    this.description = '',
    this.errorMessage,
    this.isSendingAlert = false,
    this.showActiveResponders = false,
  });

  SosState copyWith({
    SosStatus? status,
    SosFeed? feed,
    SosViewStep? viewStep,
    String? description,
    Object? errorMessage = _sosSentinel,
    bool? isSendingAlert,
    bool? showActiveResponders,
  }) {
    return SosState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      viewStep: viewStep ?? this.viewStep,
      description: description ?? this.description,
      errorMessage: identical(errorMessage, _sosSentinel)
          ? this.errorMessage
          : errorMessage as String?,
      isSendingAlert: isSendingAlert ?? this.isSendingAlert,
      showActiveResponders:
          showActiveResponders ?? this.showActiveResponders,
    );
  }
}
