part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

class ProfileTabSelected extends ProfileEvent {
  final String tabId;

  const ProfileTabSelected({required this.tabId});
}

class ProfileCityFilterSelected extends ProfileEvent {
  final String filterId;

  const ProfileCityFilterSelected({required this.filterId});
}

class ProfileSortSelected extends ProfileEvent {
  final String sortId;

  const ProfileSortSelected({required this.sortId});
}

class ProfileViewModeChanged extends ProfileEvent {
  final ProfileViewMode viewMode;

  const ProfileViewModeChanged({required this.viewMode});
}
