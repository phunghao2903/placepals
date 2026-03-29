import '../models/appointment_feed_model.dart';
import '../models/appointment_invitee_model.dart';

abstract class AppointmentLocalDataSource {
  Future<AppointmentFeedModel> getAppointmentFeed();
}

class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
  @override
  Future<AppointmentFeedModel> getAppointmentFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 140));
    return const AppointmentFeedModel(
      title: 'New Hangout',
      planNameLabel: 'Plan Name',
      planNameHint: 'e.g., Dinner at Mario\'s',
      planName: '',
      whenLabel: 'When?',
      dateLabel: 'Sat, Mar 7',
      timeLabel: '19:00',
      guestsLabel: 'Who\'s coming?',
      descriptionLabel: 'Description',
      descriptionHint: 'Add some details about the plan...',
      description: '',
      ctaLabel: 'Next: Suggest Places',
      invitees: _initialInvitees,
    );
  }
}

const List<AppointmentInviteeModel> _initialInvitees = <AppointmentInviteeModel>[
  AppointmentInviteeModel(
    id: 'sarah_jenkins',
    name: 'Sarah Jenkins',
    subtitle: 'Frequent Pal',
    avatarAssetPath: 'assets/images/profile.jpg',
    isSelected: true,
    isMuted: false,
    showRemoveBadge: true,
  ),
  AppointmentInviteeModel(
    id: 'marcus_chen',
    name: 'Marcus Chen',
    subtitle: 'Recently active',
    avatarAssetPath: 'assets/images/bean_bloom.png',
    isSelected: true,
    isMuted: false,
    showRemoveBadge: false,
  ),
  AppointmentInviteeModel(
    id: 'jessica_wong',
    name: 'Jessica Wong',
    subtitle: '@jess_w',
    avatarAssetPath: 'assets/images/cafe_tan.png',
    isSelected: true,
    isMuted: false,
    showRemoveBadge: false,
  ),
  AppointmentInviteeModel(
    id: 'david_miller',
    name: 'David Miller',
    subtitle: '@dave_mill',
    avatarAssetPath: 'assets/images/korea_food.jpeg',
    isSelected: false,
    isMuted: true,
    showRemoveBadge: false,
  ),
  AppointmentInviteeModel(
    id: 'alex_lee',
    name: 'Alex Lee',
    subtitle: '@alexlee',
    avatarAssetPath: '',
    isSelected: false,
    isMuted: true,
    showRemoveBadge: false,
  ),
  AppointmentInviteeModel(
    id: 'emma_watson',
    name: 'Emma Watson',
    subtitle: '@emma_w',
    avatarAssetPath: '',
    isSelected: false,
    isMuted: true,
    showRemoveBadge: false,
  ),
];
