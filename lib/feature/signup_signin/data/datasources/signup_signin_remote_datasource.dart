import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../models/auth_user_model.dart';

abstract class SignupSigninRemoteDataSource {
  Future<AuthUserModel> login({
    required String email,
    required String password,
  });

  Future<AuthUserModel> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email});
}

class SignupSigninRemoteDataSourceImpl implements SignupSigninRemoteDataSource {
  final FirebaseAuthService _authService;

  const SignupSigninRemoteDataSourceImpl(this._authService);

  @override
  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signIn(
        email: email,
        password: password,
      );
      final user = credential.user;

      if (user == null) {
        throw Exception('Unable to sign in right now.');
      }

      await _authService.reloadCurrentUser();
      final currentUser = _authService.currentUser ?? user;

      if (!currentUser.emailVerified) {
        await _authService.sendEmailVerification(user: currentUser);
        await _authService.signOut();
        throw Exception(
          'Please verify your email before signing in. '
          'A new verification link has been sent to your inbox.',
        );
      }

      final profile = await _authService.getUserProfile(currentUser.uid);

      return AuthUserModel(
        id: currentUser.uid,
        fullName:
            profile?['fullName'] as String? ??
            currentUser.displayName ??
            'PlacePals User',
        email: currentUser.email ?? email.trim().toLowerCase(),
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapFirebaseAuthException(error));
    }
  }

  @override
  Future<AuthUserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signUp(
        email: email,
        password: password,
      );
      final user = credential.user;

      if (user == null) {
        throw Exception('Unable to create your account right now.');
      }

      final normalizedName = fullName.trim();
      final normalizedEmail = email.trim().toLowerCase();

      await user.updateDisplayName(normalizedName);
      await _authService.saveUserProfile(
        uid: user.uid,
        fullName: normalizedName,
        email: normalizedEmail,
      );
      await _authService.sendEmailVerification(user: user);
      await _authService.signOut();

      return AuthUserModel(
        id: user.uid,
        fullName: normalizedName,
        email: normalizedEmail,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapFirebaseAuthException(error));
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapFirebaseAuthException(error));
    }
  }

  String _mapFirebaseAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Please check your connection and try again.';
      default:
        return error.message ?? 'Authentication failed. Please try again.';
    }
  }
}
