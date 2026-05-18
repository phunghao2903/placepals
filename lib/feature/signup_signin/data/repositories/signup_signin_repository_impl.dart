import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/signup_signin_repository.dart';
import '../datasources/signup_signin_remote_datasource.dart';

class SignupSigninRepositoryImpl implements SignupSigninRepository {
  final SignupSigninRemoteDataSource remoteDataSource;

  const SignupSigninRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> forgotPassword({required String email}) {
    return remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.login(email: email, password: password);
    return user.toEntity();
  }

  @override
  Future<AuthUser> loginWithGoogle() async {
    final user = await remoteDataSource.loginWithGoogle();
    return user.toEntity();
  }

  @override
  Future<AuthUser> loginWithFacebook() async {
    final user = await remoteDataSource.loginWithFacebook();
    return user.toEntity();
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.register(
      fullName: fullName,
      email: email,
      password: password,
    );
    return user.toEntity();
  }
}
