import '../entities/auth_user.dart';
import '../repositories/signup_signin_repository.dart';

class GoogleSignInUseCase {
  final SignupSigninRepository repository;

  const GoogleSignInUseCase(this.repository);

  Future<AuthUser> call() {
    return repository.loginWithGoogle();
  }
}
