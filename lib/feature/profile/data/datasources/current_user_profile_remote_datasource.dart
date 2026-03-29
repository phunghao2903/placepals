import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
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
  static const String _functionsRegion = 'asia-southeast1';
  static const String _avatarStoragePath = 'profile/avatar.jpg';
  static const String _coverStoragePath = 'profile/cover.jpg';

  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseFunctions _functions;

  CurrentUserProfileRemoteDataSourceImpl(
    this._authService, {
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    FirebaseFunctions? functions,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance,
       _functions =
           functions ?? FirebaseFunctions.instanceFor(region: _functionsRegion);

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

    final payload = <String, dynamic>{
      'displayName': input.displayName,
      'username': input.username,
      'bio': input.bio,
      'phoneNumber': input.phoneNumber,
    };

    if (input.clearAvatar) {
      payload['clearAvatar'] = true;
    } else if (uploadedAvatarUrl != null) {
      payload['avatarUrl'] = uploadedAvatarUrl;
    }

    if (input.clearCover) {
      payload['clearCover'] = true;
    } else if (uploadedCoverUrl != null) {
      payload['coverUrl'] = uploadedCoverUrl;
    }

    final callable = _functions.httpsCallable(
      'upsertCurrentUserProfile',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 20)),
    );

    await callable.call(payload);
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
}
