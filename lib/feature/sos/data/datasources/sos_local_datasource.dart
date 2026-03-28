import '../models/sos_feed_model.dart';

abstract class SosLocalDataSource {
  Future<SosFeedModel> getSosFeed();
}

class SosLocalDataSourceImpl implements SosLocalDataSource {
  @override
  Future<SosFeedModel> getSosFeed() async {
    return const SosFeedModel(
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
    );
  }
}
