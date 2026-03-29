import '../../domain/entities/appointment_feed.dart';
import 'appointment_invitee_model.dart';

class AppointmentFeedModel {
  final String title;
  final String planNameLabel;
  final String planNameHint;
  final String planName;
  final String whenLabel;
  final String dateLabel;
  final String timeLabel;
  final String guestsLabel;
  final String descriptionLabel;
  final String descriptionHint;
  final String description;
  final String ctaLabel;
  final List<AppointmentInviteeModel> invitees;

  const AppointmentFeedModel({
    required this.title,
    required this.planNameLabel,
    required this.planNameHint,
    required this.planName,
    required this.whenLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.guestsLabel,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.description,
    required this.ctaLabel,
    required this.invitees,
  });

  AppointmentFeed toEntity() {
    return AppointmentFeed(
      title: title,
      planNameLabel: planNameLabel,
      planNameHint: planNameHint,
      planName: planName,
      whenLabel: whenLabel,
      dateLabel: dateLabel,
      timeLabel: timeLabel,
      guestsLabel: guestsLabel,
      descriptionLabel: descriptionLabel,
      descriptionHint: descriptionHint,
      description: description,
      ctaLabel: ctaLabel,
      invitees: invitees
          .map((invitee) => invitee.toEntity())
          .toList(growable: false),
    );
  }
}
