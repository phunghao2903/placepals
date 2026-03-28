import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'signup_signin_event.dart';
part 'signup_signin_state.dart';

class SignupSigninBloc extends Bloc<SignupSigninEvent, SignupSigninState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  SignupSigninBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const SignupSigninState()) {
    on<SignupSigninModeChanged>(_onModeChanged);
    on<SignupSigninFullNameChanged>(_onFullNameChanged);
    on<SignupSigninEmailChanged>(_onEmailChanged);
    on<SignupSigninPasswordChanged>(_onPasswordChanged);
    on<SignupSigninConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupSigninRememberMeToggled>(_onRememberMeToggled);
    on<SignupSigninPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<SignupSigninConfirmPasswordVisibilityToggled>(
      _onConfirmPasswordVisibilityToggled,
    );
    on<SignupSigninSignInSubmitted>(_onSignInSubmitted);
    on<SignupSigninSignUpSubmitted>(_onSignUpSubmitted);
    on<SignupSigninForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<SignupSigninActionCleared>(_onActionCleared);
  }

  void _onModeChanged(
    SignupSigninModeChanged event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        mode: event.mode,
        fullName: event.clearSensitive ? '' : state.fullName,
        email: event.clearSensitive ? '' : state.email,
        password: '',
        confirmPassword: '',
        fullNameError: null,
        emailError: null,
        passwordError: null,
        confirmPasswordError: null,
        errorMessage: null,
        status: SignupSigninStatus.initial,
        currentRequest: SignupSigninRequest.none,
        completedAction: SignupSigninAction.none,
      ),
    );
  }

  void _onFullNameChanged(
    SignupSigninFullNameChanged event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        fullName: event.value,
        fullNameError: null,
        errorMessage: null,
        status: SignupSigninStatus.initial,
      ),
    );
  }

  void _onEmailChanged(
    SignupSigninEmailChanged event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.value,
        emailError: null,
        errorMessage: null,
        status: SignupSigninStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    SignupSigninPasswordChanged event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.value,
        passwordError: null,
        confirmPasswordError: null,
        errorMessage: null,
        status: SignupSigninStatus.initial,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignupSigninConfirmPasswordChanged event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.value,
        confirmPasswordError: null,
        errorMessage: null,
        status: SignupSigninStatus.initial,
      ),
    );
  }

  void _onRememberMeToggled(
    SignupSigninRememberMeToggled event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void _onPasswordVisibilityToggled(
    SignupSigninPasswordVisibilityToggled event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordVisibilityToggled(
    SignupSigninConfirmPasswordVisibilityToggled event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  Future<void> _onSignInSubmitted(
    SignupSigninSignInSubmitted event,
    Emitter<SignupSigninState> emit,
  ) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);

    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.signIn,
          errorMessage: 'Please fix the highlighted fields.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignupSigninStatus.loading,
        currentRequest: SignupSigninRequest.signIn,
        errorMessage: null,
        completedAction: SignupSigninAction.none,
      ),
    );

    try {
      await loginUseCase(email: state.email.trim(), password: state.password);
      emit(
        state.copyWith(
          status: SignupSigninStatus.success,
          currentRequest: SignupSigninRequest.signIn,
          completedAction: SignupSigninAction.signedIn,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.signIn,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onSignUpSubmitted(
    SignupSigninSignUpSubmitted event,
    Emitter<SignupSigninState> emit,
  ) async {
    final fullNameError = state.fullName.trim().isEmpty
        ? 'Please enter your full name.'
        : null;
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError =
        state.confirmPassword != state.password ||
            state.confirmPassword.trim().isEmpty
        ? 'Passwords do not match.'
        : null;

    if (fullNameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      emit(
        state.copyWith(
          fullNameError: fullNameError,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.signUp,
          errorMessage: 'Please fix the highlighted fields.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignupSigninStatus.loading,
        currentRequest: SignupSigninRequest.signUp,
        errorMessage: null,
        completedAction: SignupSigninAction.none,
      ),
    );

    try {
      await registerUseCase(
        fullName: state.fullName.trim(),
        email: state.email.trim(),
        password: state.password,
      );
      emit(
        state.copyWith(
          status: SignupSigninStatus.success,
          currentRequest: SignupSigninRequest.signUp,
          completedAction: SignupSigninAction.registered,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.signUp,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onForgotPasswordSubmitted(
    SignupSigninForgotPasswordSubmitted event,
    Emitter<SignupSigninState> emit,
  ) async {
    final emailError = _validateEmail(event.email);
    if (emailError != null) {
      emit(
        state.copyWith(
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.forgotPassword,
          errorMessage: emailError,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignupSigninStatus.loading,
        currentRequest: SignupSigninRequest.forgotPassword,
        errorMessage: null,
        completedAction: SignupSigninAction.none,
      ),
    );

    try {
      await forgotPasswordUseCase(email: event.email.trim());
      emit(
        state.copyWith(
          status: SignupSigninStatus.success,
          currentRequest: SignupSigninRequest.forgotPassword,
          completedAction: SignupSigninAction.resetLinkSent,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SignupSigninStatus.failure,
          currentRequest: SignupSigninRequest.forgotPassword,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void _onActionCleared(
    SignupSigninActionCleared event,
    Emitter<SignupSigninState> emit,
  ) {
    emit(
      state.copyWith(
        status: SignupSigninStatus.initial,
        currentRequest: SignupSigninRequest.none,
        completedAction: SignupSigninAction.none,
        errorMessage: null,
      ),
    );
  }

  String? _validateEmail(String value) {
    if (!Validators.isEmail(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.trim().length < 8) {
      return 'Password must be at least 8 characters.';
    }
    return null;
  }
}




