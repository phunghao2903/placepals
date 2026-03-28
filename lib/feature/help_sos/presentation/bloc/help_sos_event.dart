part of 'help_sos_bloc.dart';

sealed class HelpSosEvent {
  const HelpSosEvent();
}

class HelpSosStarted extends HelpSosEvent {
  const HelpSosStarted();
}

class HelpSosAlertTypeSelected extends HelpSosEvent {
  final String alertId;

  const HelpSosAlertTypeSelected({
    required this.alertId,
  });
}

class HelpSosGoToLocationTapped extends HelpSosEvent {
  const HelpSosGoToLocationTapped();
}

class HelpSosCallNowTapped extends HelpSosEvent {
  const HelpSosCallNowTapped();
}

class HelpSosBackPressed extends HelpSosEvent {
  const HelpSosBackPressed();
}

class HelpSosArrivedTapped extends HelpSosEvent {
  const HelpSosArrivedTapped();
}

class HelpSosCallEnded extends HelpSosEvent {
  const HelpSosCallEnded();
}
