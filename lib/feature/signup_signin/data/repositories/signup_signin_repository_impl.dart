import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/signup_signin_repository.dart';
import '../datasources/signup_signin_local_datasource.dart';

class SignupSigninRepositoryImpl implements SignupSigninRepository {
  final SignupSigninLocalDataSource localDataSource;

  const SignupSigninRepositoryImpl(this.localDataSource);

  @override
  Future<void> forgotPassword({required String email}) {
    return localDataSource.forgotPassword(email: email);
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final user = await localDataSource.login(email: email, password: password);
    return user.toEntity();
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final user = await localDataSource.register(
      fullName: fullName,
      email: email,
      password: password,
    );
    return user.toEntity();
  }
}
