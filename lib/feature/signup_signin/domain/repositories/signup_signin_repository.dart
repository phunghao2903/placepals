import '../entities/auth_user.dart';

abstract class SignupSigninRepository {
  Future<AuthUser> login({required String email, required String password});

  Future<AuthUser> loginWithGoogle();

  Future<AuthUser> loginWithFacebook();

  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email});
}
