part of 'sos_bloc.dart';

sealed class SosEvent {
  const SosEvent();
}

class SosStarted extends SosEvent {
  const SosStarted();
}

class SosEmergencyTypeSelected extends SosEvent {
  final String typeId;

  const SosEmergencyTypeSelected({
    required this.typeId,
  });
}

class SosVisibilityScopeSelected extends SosEvent {
  final String scopeId;

  const SosVisibilityScopeSelected({
    required this.scopeId,
  });
}

class SosDescriptionChanged extends SosEvent {
  final String description;

  const SosDescriptionChanged({
    required this.description,
  });
}
