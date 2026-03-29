import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/current_user_profile.dart';

class CurrentUserProfileModel extends CurrentUserProfile {
  const CurrentUserProfileModel({
    required super.uid,
    required super.displayName,
    required super.username,
    required super.bio,
    required super.email,
    required super.phoneNumber,
    required super.avatarUrl,
    required super.coverUrl,
    required super.createdAt,
  });

  factory CurrentUserProfileModel.fromSources({
    required User authUser,
    required Map<String, dynamic>? data,
  }) {
    final fullName =
        _asTrimmedString(data?['fullName']) ??
        authUser.displayName?.trim() ??
        'PlacePals User';
    final email =
        authUser.email?.trim().toLowerCase() ??
        _asTrimmedString(data?['email']) ??
        '';
    final username =
        _normalizeUsername(
          _asTrimmedString(data?['username']) ??
              _asTrimmedString(data?['usernameLowercase']) ??
              _fallbackUsername(
                uid: authUser.uid,
                displayName: fullName,
                email: email,
              ),
        ) ??
        _fallbackUsername(
          uid: authUser.uid,
          displayName: fullName,
          email: email,
        );

    return CurrentUserProfileModel(
      uid: authUser.uid,
      displayName: fullName,
      username: username,
      bio: _asTrimmedString(data?['bio']) ?? '',
      email: email,
      phoneNumber: _asTrimmedString(data?['phoneNumber']),
      avatarUrl: _asTrimmedString(data?['avatarUrl']),
      coverUrl: _asTrimmedString(data?['coverUrl']),
      createdAt:
          _asDateTime(data?['createdAt']) ?? authUser.metadata.creationTime,
    );
  }

  CurrentUserProfile toEntity() {
    return CurrentUserProfile(
      uid: uid,
      displayName: displayName,
      username: username,
      bio: bio,
      email: email,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      coverUrl: coverUrl,
      createdAt: createdAt,
    );
  }

  static String? _asTrimmedString(Object? value) {
    if (value is! String) {
      return null;
    }

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static DateTime? _asDateTime(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return null;
  }

  static String _fallbackUsername({
    required String uid,
    required String displayName,
    required String email,
  }) {
    final source = email.split('@').first.isNotEmpty
        ? email.split('@').first
        : displayName;
    final normalized = _normalizeUsername(source) ?? 'user';
    final uidSuffix = uid
        .substring(0, uid.length >= 4 ? 4 : uid.length)
        .toLowerCase();
    final base = normalized.length > 15
        ? normalized.substring(0, 15)
        : normalized;
    final candidate = '$base$uidSuffix';
    return candidate.length > 20 ? candidate.substring(0, 20) : candidate;
  }

  static String? _normalizeUsername(String value) {
    final normalized = value
        .trim()
        .toLowerCase()
        .replaceAll('@', '')
        .replaceAll(RegExp(r'[^a-z0-9._]'), '');

    if (normalized.isEmpty) {
      return null;
    }

    if (normalized.length >= 3) {
      return normalized.length > 20 ? normalized.substring(0, 20) : normalized;
    }

    return null;
  }
}
