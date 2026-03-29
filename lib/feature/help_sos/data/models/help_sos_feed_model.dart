import '../../domain/entities/help_sos_feed.dart';

class HelpSosFeedModel {
  final List<HelpSosAlertModel> alerts;
  final int initialAlertIndex;
  final HelpSosRescueMapModel rescueMap;
  final HelpSosCallSessionModel callSession;

  const HelpSosFeedModel({
    required this.alerts,
    required this.initialAlertIndex,
    required this.rescueMap,
    required this.callSession,
  });

  HelpSosFeed toEntity() {
    return HelpSosFeed(
      alerts: alerts.map((item) => item.toEntity()).toList(growable: false),
      initialAlertIndex: initialAlertIndex,
      rescueMap: rescueMap.toEntity(),
      callSession: callSession.toEntity(),
    );
  }
}

class HelpSosAlertModel {
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

  const HelpSosAlertModel({
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

  HelpSosAlert toEntity() {
    return HelpSosAlert(
      id: id,
      headerTitle: headerTitle,
      receivedLabel: receivedLabel,
      senderName: senderName,
      emergencyLabel: emergencyLabel,
      emergencyTitle: emergencyTitle,
      emergencyDescription: emergencyDescription,
      routeDistanceLabel: routeDistanceLabel,
      primaryActionLabel: primaryActionLabel,
      secondaryActionLabel: secondaryActionLabel,
      mapLocationLabel: mapLocationLabel,
      iconKey: iconKey,
    );
  }
}

class HelpSosRescueMapModel {
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

  const HelpSosRescueMapModel({
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

  HelpSosRescueMap toEntity() {
    return HelpSosRescueMap(
      title: title,
      cityLabel: cityLabel,
      searchLabel: searchLabel,
      helperName: helperName,
      helperAddress: helperAddress,
      helperStatus: helperStatus,
      helperBattery: helperBattery,
      callNowLabel: callNowLabel,
      imHereLabel: imHereLabel,
      noteLabel: noteLabel,
    );
  }
}

class HelpSosCallSessionModel {
  final String participantName;
  final String statusLabel;

  const HelpSosCallSessionModel({
    required this.participantName,
    required this.statusLabel,
  });

  HelpSosCallSession toEntity() {
    return HelpSosCallSession(
      participantName: participantName,
      statusLabel: statusLabel,
    );
  }
}
