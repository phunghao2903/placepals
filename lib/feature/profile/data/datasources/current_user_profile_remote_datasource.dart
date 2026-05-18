import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../domain/entities/update_current_user_profile_input.dart';
import '../models/current_user_profile_model.dart';

abstract class CurrentUserProfileRemoteDataSource {
  Stream<CurrentUserProfileModel> watchCurrentUserProfile();

  Future<CurrentUserProfileModel> getCurrentUserProfile();

  Future<void> updateCurrentUserProfile(UpdateCurrentUserProfileInput input);
}

class CurrentUserProfileRemoteDataSourceImpl
    implements CurrentUserProfileRemoteDataSource {
  static const String _avatarStoragePath = 'profile/avatar.jpg';
  static const String _coverStoragePath = 'profile/cover.jpg';

  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CurrentUserProfileRemoteDataSourceImpl(
    this._authService, {
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  @override
  Stream<CurrentUserProfileModel> watchCurrentUserProfile() {
    final authUser = _requireCurrentUser();

    return _usersCollection.doc(authUser.uid).snapshots().map((snapshot) {
      final latestAuthUser = _authService.currentUser ?? authUser;
      return CurrentUserProfileModel.fromSources(
        authUser: latestAuthUser,
        data: snapshot.data(),
      );
    });
  }

  @override
  Future<CurrentUserProfileModel> getCurrentUserProfile() async {
    final authUser = _requireCurrentUser();
    final snapshot = await _usersCollection.doc(authUser.uid).get();

    return CurrentUserProfileModel.fromSources(
      authUser: _authService.currentUser ?? authUser,
      data: snapshot.data(),
    );
  }

  @override
  Future<void> updateCurrentUserProfile(
    UpdateCurrentUserProfileInput input,
  ) async {
    final authUser = _requireCurrentUser();

    String? uploadedAvatarUrl;
    String? uploadedCoverUrl;

    if (input.clearAvatar) {
      await _deleteImage(
        path: _storagePathFor(authUser.uid, _avatarStoragePath),
      );
    } else if (input.avatarBytes != null) {
      uploadedAvatarUrl = await _uploadImage(
        path: _storagePathFor(authUser.uid, _avatarStoragePath),
        bytes: input.avatarBytes!,
        contentType: input.avatarContentType,
      );
    }

    if (input.clearCover) {
      await _deleteImage(
        path: _storagePathFor(authUser.uid, _coverStoragePath),
      );
    } else if (input.coverBytes != null) {
      uploadedCoverUrl = await _uploadImage(
        path: _storagePathFor(authUser.uid, _coverStoragePath),
        bytes: input.coverBytes!,
        contentType: input.coverContentType,
      );
    }

    final userRef = _usersCollection.doc(authUser.uid);
    final usernamesRef = _firestore.collection('usernames').doc(input.username);

    await _firestore.runTransaction((transaction) async {
      final userSnapshot = await transaction.get(userRef);
      final currentData = userSnapshot.data();
      final existingUsername = _normalizeUsername(
        currentData?['usernameLowercase'] ?? currentData?['username'],
      );
      final usernameSnapshot = await transaction.get(usernamesRef);
      final usernameOwner = _asTrimmedString(usernameSnapshot.data()?['uid']);

      if (usernameSnapshot.exists &&
          usernameOwner != null &&
          usernameOwner != authUser.uid) {
        throw Exception('Username is already taken.');
      }

      transaction.set(
        usernamesRef,
        <String, dynamic>{
          'uid': authUser.uid,
          'username': input.username,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      if (existingUsername != null && existingUsername != input.username) {
        transaction.delete(_firestore.collection('usernames').doc(existingUsername));
      }

      final payload = <String, dynamic>{
        'fullName': input.displayName,
        'username': input.username,
        'usernameLowercase': input.username,
        'bio': input.bio.trim().isEmpty ? null : input.bio.trim(),
        'phoneNumber': input.phoneNumber,
        'email':
            (_authService.currentUser?.email ?? authUser.email ?? '')
                .trim()
                .toLowerCase(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (!userSnapshot.exists) {
        payload['createdAt'] = FieldValue.serverTimestamp();
      }

      if (input.clearAvatar) {
        payload['avatarUrl'] = null;
      } else if (uploadedAvatarUrl != null) {
        payload['avatarUrl'] = uploadedAvatarUrl;
      }

      if (input.clearCover) {
        payload['coverUrl'] = null;
      } else if (uploadedCoverUrl != null) {
        payload['coverUrl'] = uploadedCoverUrl;
      }

      transaction.set(userRef, payload, SetOptions(merge: true));
    });

    await authUser.updateDisplayName(input.displayName);
    await _authService.reloadCurrentUser();
  }

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  String _storagePathFor(String uid, String suffix) => 'users/$uid/$suffix';

  Future<String> _uploadImage({
    required String path,
    required Uint8List bytes,
    String? contentType,
  }) async {
    final ref = _storage.ref().child(path);
    final metadata = SettableMetadata(
      contentType: contentType ?? 'image/jpeg',
      cacheControl: 'public,max-age=3600',
    );

    await ref.putData(bytes, metadata);
    return ref.getDownloadURL();
  }

  Future<void> _deleteImage({required String path}) async {
    try {
      await _storage.ref().child(path).delete();
    } on FirebaseException catch (error) {
      if (error.code != 'object-not-found') {
        rethrow;
      }
    }
  }

  User _requireCurrentUser() {
    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      throw Exception('You need to be signed in to update your profile.');
    }

    return currentUser;
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

    final normalized = trimmed.replaceFirst(RegExp(r'^@+'), '').toLowerCase();
    if (normalized.isEmpty) {
      return null;
    }

    return normalized;
  }
}
