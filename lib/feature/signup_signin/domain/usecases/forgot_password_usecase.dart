import '../repositories/signup_signin_repository.dart';

class ForgotPasswordUseCase {
  final SignupSigninRepository repository;

  const ForgotPasswordUseCase(this.repository);

  Future<void> call({required String email}) {
    return repository.forgotPassword(email: email);
  }
}
