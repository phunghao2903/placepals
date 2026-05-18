import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../domain/entities/appointment_create_input.dart';
import '../models/appointment_feed_model.dart';
import '../models/appointment_invitee_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentFeedModel> getAppointmentFeed();

  Future<String> createAppointment(AppointmentCreateInput input);
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore;

  AppointmentRemoteDataSourceImpl(
    this._authService, {
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<AppointmentFeedModel> getAppointmentFeed() async {
    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      throw Exception('You need to be signed in to invite registered users.');
    }

    final snapshot = await _firestore.collection('users').limit(40).get();
    final invitees = <AppointmentInviteeModel>[];

    for (final document in snapshot.docs) {
      if (document.id == currentUser.uid) {
        continue;
      }

      final data = document.data();
      final name =
          _asTrimmedString(data['fullName']) ??
          _asTrimmedString(data['displayName']) ??
          _asTrimmedString(data['email']);
      if (name == null) {
        continue;
      }

      final username = _normalizeUsername(
        data['usernameLowercase'] ?? data['username'],
      );
      final avatarUrl = _asTrimmedString(data['avatarUrl']) ?? '';
      final inviteeIndex = invitees.length;

      invitees.add(
        AppointmentInviteeModel(
          id: document.id,
          name: name,
          subtitle: username != null
              ? '@$username'
              : _asTrimmedString(data['email']) ?? 'Registered user',
          avatarAssetPath: avatarUrl,
          isSelected: inviteeIndex < 3,
          isMuted: inviteeIndex >= 3,
          showRemoveBadge: inviteeIndex == 0,
        ),
      );
    }

    return AppointmentFeedModel(
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
      invitees: invitees,
    );
  }

  @override
  Future<String> createAppointment(AppointmentCreateInput input) async {
    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      throw Exception('You need to be signed in to create a hangout.');
    }

    final selectedInvitees = input.invitees
        .where((invitee) => invitee.isSelected)
        .toList(growable: false);
    if (selectedInvitees.isEmpty) {
      throw Exception('Select at least one registered user.');
    }

    final title = input.planName.trim().isEmpty
        ? 'New Hangout'
        : input.planName.trim();
    final document = _firestore.collection('appointments').doc();

    await document.set(<String, dynamic>{
      'hostUid': currentUser.uid,
      'hostDisplayName':
          _asTrimmedString(currentUser.displayName) ??
          _asTrimmedString(currentUser.email) ??
          'Host',
      'title': title,
      'description': input.description.trim().isEmpty
          ? null
          : input.description.trim(),
      'dateLabel': input.dateLabel,
      'timeLabel': input.timeLabel,
      'status': 'draft',
      'inviteeUids': selectedInvitees.map((invitee) => invitee.id).toList(),
      'invitees': selectedInvitees
          .map(
            (invitee) => <String, dynamic>{
              'uid': invitee.id,
              'name': invitee.name,
              'subtitle': invitee.subtitle,
              'avatarUrl': invitee.avatarAssetPath.trim().isEmpty
                  ? null
                  : invitee.avatarAssetPath.trim(),
              'status': 'invited',
            },
          )
          .toList(growable: false),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return document.id;
  }

  static String? _asTrimmedString(Object? value) {
    if (value is! String) {
      return null;
    }

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String? _normalizeUsername(Object? value) {
    final trimmed = _asTrimmedString(value);
    if (trimmed == null) {
      return null;
    }

    return trimmed.replaceFirst(RegExp(r'^@+'), '').toLowerCase();
  }
}
