import '../models/sos_feed_model.dart';

abstract class SosLocalDataSource {
  Future<SosFeedModel> getSosFeed();
}

class SosLocalDataSourceImpl implements SosLocalDataSource {
  @override
  Future<SosFeedModel> getSosFeed() async {
    return const SosFeedModel(
      intro: SosIntroContentModel(
        heroLabel: 'SOS',
        helperText: 'Press and hold to broadcast\na Help Moment',
        trailingActionLabel: 'Cancel',
      ),
      helpComposer: SosHelpComposerModel(
        title: 'Create Help Moment',
        subtitle: 'SELECT EMERGENCY TYPE',
        descriptionLabel: 'DESCRIPTION',
        descriptionHint: 'Describe the situation (optional)...',
        visibilityScopeLabel: 'VISIBILITY SCOPE',
        sendHelpLabel: 'Sos Send Help Alert',
        emergencyTypes: <SosEmergencyTypeModel>[
          SosEmergencyTypeModel(
            id: 'vehicle',
            title: 'Vehicle\nBreakdown',
            iconKey: 'vehicle',
            isSelected: true,
          ),
          SosEmergencyTypeModel(
            id: 'medical',
            title: 'Medical',
            iconKey: 'medical',
            isSelected: false,
          ),
          SosEmergencyTypeModel(
            id: 'lost',
            title: 'Lost',
            iconKey: 'lost',
            isSelected: false,
          ),
          SosEmergencyTypeModel(
            id: 'unsafe',
            title: 'Unsafe',
            iconKey: 'unsafe',
            isSelected: false,
          ),
        ],
        visibilityScopes: <SosVisibilityScopeModel>[
          SosVisibilityScopeModel(
            id: 'all-friends',
            label: 'All Friends',
            isSelected: true,
          ),
          SosVisibilityScopeModel(
            id: 'close-friends',
            label: 'Close Friends',
            isSelected: false,
          ),
        ],
      ),
      activeAlert: SosActiveAlertModel(
        title: 'Active SOS',
        city: 'Ho Chi Minh City',
        locationPrefix: "Hi! I'm on",
        locationName: 'Thu Dau Mot, District 1',
        respondersTitle: 'Active Responders',
        respondersEmptyLabel: 'Chua co ai',
        markSafeLabel: 'Mark as Safe',
        holdToCancelLabel: 'HOLD TO CANCEL EMERGENCY SIGNAL',
        responders: <SosResponderModel>[
          SosResponderModel(
            id: 'nhat',
            name: 'NHAT Toi Cuu',
            details: 'Close Friend • 2 min',
            etaLabel: 'On the way',
            avatarTintHex: 0xFFE8D9C6,
          ),
          SosResponderModel(
            id: 'duc',
            name: 'DUC PALMER PeterNgoz',
            details: '127 km away • 25 min',
            etaLabel: 'On the way',
            avatarTintHex: 0xFFC8DCC7,
          ),
        ],
      ),
    );
  }
}
