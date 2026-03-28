import '../entities/auth_user.dart';
import '../repositories/signup_signin_repository.dart';

class RegisterUseCase {
  final SignupSigninRepository repository;

  const RegisterUseCase(this.repository);

  Future<AuthUser> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return repository.register(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
