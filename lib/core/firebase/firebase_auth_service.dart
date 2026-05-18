import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static const String _androidGoogleServerClientId =
      '330723890500-borld7anjh63tgmbk822ksbsd4b5m0nj.apps.googleusercontent.com';

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  bool _googleSignInInitialized = false;

  FirebaseAuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<User?> userChanges() => _auth.userChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      return _auth.signInWithPopup(provider);
    }

    if (!_googleSignInInitialized) {
      await GoogleSignIn.instance.initialize(
        serverClientId: _androidGoogleServerClientId,
      );
      _googleSignInInitialized = true;
    }

    // Clear any previously selected Google account so Android is more likely
    // to show the account chooser instead of silently reusing the last session.
    try {
      await GoogleSignIn.instance.disconnect();
    } catch (_) {
      try {
        await GoogleSignIn.instance.signOut();
      } catch (_) {}
    }

    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    if (kIsWeb) {
      final provider = FacebookAuthProvider();
      return _auth.signInWithPopup(provider);
    }

    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.cancelled) {
      throw Exception('Facebook sign-in was cancelled.');
    }

    if (result.status != LoginStatus.success || result.accessToken == null) {
      throw Exception(
        result.message ?? 'Facebook sign-in failed. Please try again.',
      );
    }

    final credential = FacebookAuthProvider.credential(
      result.accessToken!.tokenString,
    );

    return _auth.signInWithCredential(credential);
  }

  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email.trim().toLowerCase());
  }

  Future<void> sendEmailVerification({User? user}) async {
    final targetUser = user ?? _auth.currentUser;
    if (targetUser == null || targetUser.emailVerified) {
      return;
    }

    await targetUser.sendEmailVerification();
  }

  Future<void> reloadCurrentUser() async {
    await _auth.currentUser?.reload();
  }

  Future<void> signOut() async {
    await _auth.signOut();

    try {
      if (_googleSignInInitialized) {
        try {
          await GoogleSignIn.instance.disconnect();
        } catch (_) {
          await GoogleSignIn.instance.signOut();
        }
      }
    } catch (_) {}

    try {
      await FacebookAuth.instance.logOut();
    } catch (_) {}
  }

  Future<void> markCurrentUserLogin() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }

    await _firestore.collection('users').doc(user.uid).set(<String, dynamic>{
      'lastLoginAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
  }) {
    return _firestore.collection('users').doc(uid).set(<String, dynamic>{
      'fullName': fullName.trim(),
      'email': email.trim().toLowerCase(),
      'username': null,
      'usernameLowercase': null,
      'bio': null,
      'phoneNumber': null,
      'avatarUrl': null,
      'coverUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    return snapshot.data();
  }
}
