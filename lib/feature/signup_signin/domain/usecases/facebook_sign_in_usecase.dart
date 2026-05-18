import '../entities/auth_user.dart';
import '../repositories/signup_signin_repository.dart';

class FacebookSignInUseCase {
  final SignupSigninRepository repository;

  const FacebookSignInUseCase(this.repository);

  Future<AuthUser> call() {
    return repository.loginWithFacebook();
  }
}
