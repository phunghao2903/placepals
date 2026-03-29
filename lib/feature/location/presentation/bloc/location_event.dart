part of 'location_bloc.dart';

sealed class LocationEvent {
  const LocationEvent();
}

class LocationStarted extends LocationEvent {
  final String? initialLocationId;

  const LocationStarted({this.initialLocationId});
}

class LocationSearchChanged extends LocationEvent {
  final String query;

  const LocationSearchChanged({required this.query});
}

class LocationSelected extends LocationEvent {
  final String locationId;

  const LocationSelected({required this.locationId});
}
