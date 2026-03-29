class HelpSosFeed {
  final List<HelpSosAlert> alerts;
  final int initialAlertIndex;
  final HelpSosRescueMap rescueMap;
  final HelpSosCallSession callSession;

  const HelpSosFeed({
    required this.alerts,
    required this.initialAlertIndex,
    required this.rescueMap,
    required this.callSession,
  });
}

class HelpSosAlert {
  final String id;
  final String headerTitle;
  final String receivedLabel;
  final String senderName;
  final String emergencyLabel;
  final String emergencyTitle;
  final String emergencyDescription;
  final String routeDistanceLabel;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final String mapLocationLabel;
  final String iconKey;

  const HelpSosAlert({
    required this.id,
    required this.headerTitle,
    required this.receivedLabel,
    required this.senderName,
    required this.emergencyLabel,
    required this.emergencyTitle,
    required this.emergencyDescription,
    required this.routeDistanceLabel,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.mapLocationLabel,
    required this.iconKey,
  });
}

class HelpSosRescueMap {
  final String title;
  final String cityLabel;
  final String searchLabel;
  final String helperName;
  final String helperAddress;
  final String helperStatus;
  final String helperBattery;
  final String callNowLabel;
  final String imHereLabel;
  final String noteLabel;

  const HelpSosRescueMap({
    required this.title,
    required this.cityLabel,
    required this.searchLabel,
    required this.helperName,
    required this.helperAddress,
    required this.helperStatus,
    required this.helperBattery,
    required this.callNowLabel,
    required this.imHereLabel,
    required this.noteLabel,
  });
}

class HelpSosCallSession {
  final String participantName;
  final String statusLabel;

  const HelpSosCallSession({
    required this.participantName,
    required this.statusLabel,
  });
}
