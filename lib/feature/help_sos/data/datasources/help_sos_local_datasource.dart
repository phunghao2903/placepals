import '../models/help_sos_feed_model.dart';

abstract class HelpSosLocalDataSource {
  Future<HelpSosFeedModel> getHelpSosFeed();
}

class HelpSosLocalDataSourceImpl implements HelpSosLocalDataSource {
  @override
  Future<HelpSosFeedModel> getHelpSosFeed() async {
    return const HelpSosFeedModel(
      initialAlertIndex: 0,
      alerts: <HelpSosAlertModel>[
        HelpSosAlertModel(
          id: 'vehicle',
          headerTitle: 'EMERGENCY ALERT',
          receivedLabel: 'RECEIVED 2M AGO',
          senderName: 'Vo Van Huy',
          emergencyLabel: 'Nature of emergency',
          emergencyTitle: 'Vehicle Breakdown',
          emergencyDescription: 'Car stalled on Highway 42, near Exit 12.',
          routeDistanceLabel: '2.4km away',
          primaryActionLabel: 'Go to Location',
          secondaryActionLabel: 'Call Now',
          mapLocationLabel: 'Minh City',
          iconKey: 'vehicle',
        ),
        HelpSosAlertModel(
          id: 'medical',
          headerTitle: 'EMERGENCY ALERT',
          receivedLabel: 'RECEIVED 2M AGO',
          senderName: 'Vo Van Huy',
          emergencyLabel: 'Nature of emergency',
          emergencyTitle: 'Medical',
          emergencyDescription: 'Need urgent help, low air and feeling dizzy.',
          routeDistanceLabel: '2.4km away',
          primaryActionLabel: 'Go to Location',
          secondaryActionLabel: 'Call Now',
          mapLocationLabel: 'Minh City',
          iconKey: 'medical',
        ),
        HelpSosAlertModel(
          id: 'lost',
          headerTitle: 'EMERGENCY ALERT',
          receivedLabel: 'RECEIVED 2M AGO',
          senderName: 'Vo Van Huy',
          emergencyLabel: 'Nature of emergency',
          emergencyTitle: 'Lost',
          emergencyDescription: 'Cannot find the route back, can you locate me?',
          routeDistanceLabel: '2.4km away',
          primaryActionLabel: 'Go to Location',
          secondaryActionLabel: 'Call Now',
          mapLocationLabel: 'Minh City',
          iconKey: 'lost',
        ),
        HelpSosAlertModel(
          id: 'unsafe',
          headerTitle: 'EMERGENCY ALERT',
          receivedLabel: 'RECEIVED 2M AGO',
          senderName: 'Vo Van Huy',
          emergencyLabel: 'Nature of emergency',
          emergencyTitle: 'Unsafe',
          emergencyDescription:
              'Feeling unsafe right now, need help and safe ride support.',
          routeDistanceLabel: '2.4km away',
          primaryActionLabel: 'Go to Location',
          secondaryActionLabel: 'Call Now',
          mapLocationLabel: 'Minh City',
          iconKey: 'unsafe',
        ),
      ],
      rescueMap: HelpSosRescueMapModel(
        title: 'Active Rescue Map',
        cityLabel: 'HCMC',
        searchLabel: 'Vo Van Huy, District 7',
        helperName: 'Nhat toi cuu',
        helperAddress: 'Phuong Chanh 5, District 7',
        helperStatus: 'ACTIVE',
        helperBattery: '12% - Low battery Alert',
        callNowLabel: 'Call Now',
        imHereLabel: "I'm Here",
        noteLabel: 'Tracing your location in real-time',
      ),
      callSession: HelpSosCallSessionModel(
        participantName: 'Vo Van Huy',
        statusLabel: 'Audio Recording Is Active',
      ),
    );
  }
}
