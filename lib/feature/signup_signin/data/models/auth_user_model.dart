import '../../domain/entities/auth_user.dart';

class AuthUserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;

  const AuthUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });

  AuthUser toEntity() {
    return AuthUser(id: id, fullName: fullName, email: email);
  }
}
