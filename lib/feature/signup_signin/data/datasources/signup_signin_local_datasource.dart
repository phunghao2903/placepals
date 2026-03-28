import '../models/auth_user_model.dart';

abstract class SignupSigninLocalDataSource {
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

class SignupSigninLocalDataSourceImpl implements SignupSigninLocalDataSource {
  final Map<String, AuthUserModel> _users = <String, AuthUserModel>{
    'demo@placepals.com': const AuthUserModel(
      id: 'demo-user',
      fullName: 'PlacePals Demo',
      email: 'demo@placepals.com',
    ),
  };
  final Map<String, String> _passwords = <String, String>{
    'demo@placepals.com': 'password123',
  };

  int _counter = 2;

  @override
  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final normalizedEmail = email.trim().toLowerCase();
    final user = _users[normalizedEmail];
    final savedPassword = _passwords[normalizedEmail];

    if (user == null || savedPassword != password) {
      throw Exception('Incorrect email or password.');
    }

    return user;
  }

  @override
  Future<AuthUserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final normalizedEmail = email.trim().toLowerCase();
    if (_users.containsKey(normalizedEmail)) {
      throw Exception('An account with this email already exists.');
    }

    final user = AuthUserModel(
      id: 'user-${_counter++}',
      fullName: fullName.trim(),
      email: normalizedEmail,
    );

    _users[normalizedEmail] = user;
    _passwords[normalizedEmail] = password;
    return user;
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final normalizedEmail = email.trim().toLowerCase();
    if (!_users.containsKey(normalizedEmail)) {
      throw Exception('No account found for that email address.');
    }
  }
}
