part of 'signup_signin_bloc.dart';

sealed class SignupSigninEvent {
  const SignupSigninEvent();
}

class SignupSigninModeChanged extends SignupSigninEvent {
  final SignupSigninMode mode;
  final bool clearSensitive;

  const SignupSigninModeChanged({
    required this.mode,
    this.clearSensitive = false,
  });
}

class SignupSigninFullNameChanged extends SignupSigninEvent {
  final String value;

  const SignupSigninFullNameChanged(this.value);
}

class SignupSigninEmailChanged extends SignupSigninEvent {
  final String value;

  const SignupSigninEmailChanged(this.value);
}

class SignupSigninPasswordChanged extends SignupSigninEvent {
  final String value;

  const SignupSigninPasswordChanged(this.value);
}

class SignupSigninConfirmPasswordChanged extends SignupSigninEvent {
  final String value;

  const SignupSigninConfirmPasswordChanged(this.value);
}

class SignupSigninRememberMeToggled extends SignupSigninEvent {
  const SignupSigninRememberMeToggled();
}

class SignupSigninPasswordVisibilityToggled extends SignupSigninEvent {
  const SignupSigninPasswordVisibilityToggled();
}

class SignupSigninConfirmPasswordVisibilityToggled extends SignupSigninEvent {
  const SignupSigninConfirmPasswordVisibilityToggled();
}

class SignupSigninSignInSubmitted extends SignupSigninEvent {
  const SignupSigninSignInSubmitted();
}

class SignupSigninSignUpSubmitted extends SignupSigninEvent {
  const SignupSigninSignUpSubmitted();
}

class SignupSigninForgotPasswordSubmitted extends SignupSigninEvent {
  final String email;

  const SignupSigninForgotPasswordSubmitted({required this.email});
}

class SignupSigninActionCleared extends SignupSigninEvent {
  const SignupSigninActionCleared();
}
