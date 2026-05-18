part of 'signup_signin_bloc.dart';

enum SignupSigninMode { signIn, signUp }

enum SignupSigninStatus { initial, loading, success, failure }

enum SignupSigninRequest {
  none,
  signIn,
  googleSignIn,
  facebookSignIn,
  signUp,
  forgotPassword,
}

enum SignupSigninAction { none, signedIn, registered, resetLinkSent }

class SignupSigninState {
  final SignupSigninMode mode;
  final SignupSigninStatus status;
  final SignupSigninRequest currentRequest;
  final SignupSigninAction completedAction;
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool rememberMe;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  const SignupSigninState({
    this.mode = SignupSigninMode.signIn,
    this.status = SignupSigninStatus.initial,
    this.currentRequest = SignupSigninRequest.none,
    this.completedAction = SignupSigninAction.none,
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.rememberMe = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.fullNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.errorMessage,
  });

  SignupSigninState copyWith({
    SignupSigninMode? mode,
    SignupSigninStatus? status,
    SignupSigninRequest? currentRequest,
    SignupSigninAction? completedAction,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? rememberMe,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? fullNameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
  }) {
    return SignupSigninState(
      mode: mode ?? this.mode,
      status: status ?? this.status,
      currentRequest: currentRequest ?? this.currentRequest,
      completedAction: completedAction ?? this.completedAction,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      fullNameError: fullNameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      errorMessage: errorMessage,
    );
  }
}
