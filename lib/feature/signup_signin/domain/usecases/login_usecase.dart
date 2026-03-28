import '../entities/auth_user.dart';
import '../repositories/signup_signin_repository.dart';

class LoginUseCase {
  final SignupSigninRepository repository;

  const LoginUseCase(this.repository);

  Future<AuthUser> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
