part of 'help_sos_bloc.dart';

enum HelpSosStatus {
  initial,
  loading,
  success,
  failure,
}

enum HelpSosScreen {
  alert,
  rescueMap,
  call,
}

const Object _helpSosSentinel = Object();

class HelpSosState {
  final HelpSosStatus status;
  final HelpSosFeed? feed;
  final HelpSosScreen screen;
  final HelpSosScreen resumeScreen;
  final String selectedAlertId;
  final bool hasArrived;
  final String? errorMessage;

  const HelpSosState({
    this.status = HelpSosStatus.initial,
    this.feed,
    this.screen = HelpSosScreen.alert,
    this.resumeScreen = HelpSosScreen.alert,
    this.selectedAlertId = '',
    this.hasArrived = false,
    this.errorMessage,
  });

  HelpSosAlert? get selectedAlert {
    final currentFeed = feed;
    if (currentFeed == null) return null;

    for (final alert in currentFeed.alerts) {
      if (alert.id == selectedAlertId) {
        return alert;
      }
    }

    return currentFeed.alerts.isEmpty ? null : currentFeed.alerts.first;
  }

  HelpSosState copyWith({
    HelpSosStatus? status,
    HelpSosFeed? feed,
    HelpSosScreen? screen,
    HelpSosScreen? resumeScreen,
    String? selectedAlertId,
    bool? hasArrived,
    Object? errorMessage = _helpSosSentinel,
  }) {
    return HelpSosState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      screen: screen ?? this.screen,
      resumeScreen: resumeScreen ?? this.resumeScreen,
      selectedAlertId: selectedAlertId ?? this.selectedAlertId,
      hasArrived: hasArrived ?? this.hasArrived,
      errorMessage: identical(errorMessage, _helpSosSentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
