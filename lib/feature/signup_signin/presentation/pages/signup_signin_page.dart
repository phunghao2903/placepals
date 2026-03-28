import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../bottom_appbar/presentation/pages/bottom_appbar_page.dart';
import '../bloc/signup_signin_bloc.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_success_dialog.dart';
import '../widgets/forgot_password_dialog.dart';
import '../widgets/social_auth_button.dart';

class SignupSigninPage extends StatelessWidget {
  final bool startInSignUp;

  const SignupSigninPage({super.key, this.startInSignUp = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupSigninBloc>(
      create: (_) => getIt<SignupSigninBloc>()
        ..add(
          SignupSigninModeChanged(
            mode: startInSignUp
                ? SignupSigninMode.signUp
                : SignupSigninMode.signIn,
          ),
        ),
      child: _SignupSigninView(startInSignUp: startInSignUp),
    );
  }
}

class _SignupSigninView extends StatefulWidget {
  final bool startInSignUp;

  const _SignupSigninView({required this.startInSignUp});

  @override
  State<_SignupSigninView> createState() => _SignupSigninViewState();
}

class _SignupSigninViewState extends State<_SignupSigninView> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController(
      text: widget.startInSignUp ? '' : 'demo@placepals.com',
    );
    _passwordController = TextEditingController(
      text: widget.startInSignUp ? '' : 'password123',
    );
    _confirmPasswordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final bloc = context.read<SignupSigninBloc>();
      bloc.add(SignupSigninEmailChanged(_emailController.text));
      bloc.add(SignupSigninPasswordChanged(_passwordController.text));
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupSigninBloc, SignupSigninState>(
      listenWhen: (previous, current) =>
          previous.mode != current.mode ||
          previous.completedAction != current.completedAction,
      listener: (context, state) async {
        _syncControllers(state);

        if (state.completedAction == SignupSigninAction.signedIn) {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const BottomAppBarPage()),
          );
          return;
        }

        if (state.completedAction == SignupSigninAction.registered) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => AuthSuccessDialog(
              onContinue: () {
                Navigator.of(context).pop();
                context.read<SignupSigninBloc>().add(
                  const SignupSigninModeChanged(
                    mode: SignupSigninMode.signIn,
                    clearSensitive: true,
                  ),
                );
                context.read<SignupSigninBloc>().add(
                  const SignupSigninActionCleared(),
                );
              },
            ),
          );
          return;
        }

        if (state.completedAction == SignupSigninAction.resetLinkSent) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset link sent. Please check your inbox.'),
            ),
          );
          context.read<SignupSigninBloc>().add(
            const SignupSigninActionCleared(),
          );
        }
      },
      builder: (context, state) {
        final isSignUp = state.mode == SignupSigninMode.signUp;
        final isLoading = state.status == SignupSigninStatus.loading;
        final isSubmitting =
            isLoading &&
            (state.currentRequest == SignupSigninRequest.signIn ||
                state.currentRequest == SignupSigninRequest.signUp);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                if (isSignUp)
                  Positioned(
                    top: -70,
                    right: -40,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFD1CC).withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                if (isSignUp)
                  Positioned(
                    bottom: 20,
                    left: -70,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    48,
                    24,
                    24 + MediaQuery.viewInsetsOf(context).bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.of(context).maybePop(),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: isSignUp
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Back',
                                style: AppTextStyles.body2.copyWith(
                                  color: isSignUp
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const AuthLogo(size: 56, titleSize: 24),
                      const SizedBox(height: 24),
                      Text(
                        isSignUp ? 'Create Account' : 'Welcome back!',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isSignUp
                            ? 'Join the place-sharing community'
                            : 'Sign in to continue exploring',
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (isSignUp) ...<Widget>[
                        AuthInputField(
                          label: 'Full Name',
                          hintText: 'Your full name',
                          controller: _fullNameController,
                          leadingIcon: Icons.person_outline_rounded,
                          onChanged: (value) {
                            context.read<SignupSigninBloc>().add(
                              SignupSigninFullNameChanged(value),
                            );
                          },
                          errorText: state.fullNameError,
                          trailing: _validationIcon(
                            show:
                                _fullNameController.text.trim().isNotEmpty &&
                                state.fullNameError == null,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      AuthInputField(
                        label: 'Email',
                        hintText: 'email@example.com',
                        controller: _emailController,
                        leadingIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          context.read<SignupSigninBloc>().add(
                            SignupSigninEmailChanged(value),
                          );
                        },
                        errorText: state.emailError,
                        trailing: isSignUp
                            ? _validationIcon(
                                show:
                                    Validators.isEmail(_emailController.text) &&
                                    state.emailError == null,
                              )
                            : null,
                      ),
                      const SizedBox(height: 20),
                      AuthInputField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        leadingIcon: Icons.lock_outline_rounded,
                        obscureText: state.obscurePassword,
                        onChanged: (value) {
                          context.read<SignupSigninBloc>().add(
                            SignupSigninPasswordChanged(value),
                          );
                        },
                        errorText: state.passwordError,
                        trailing: IconButton(
                          onPressed: () {
                            context.read<SignupSigninBloc>().add(
                              const SignupSigninPasswordVisibilityToggled(),
                            );
                          },
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                      ),
                      if (isSignUp) ...<Widget>[
                        const SizedBox(height: 20),
                        AuthInputField(
                          label: 'Confirm Password',
                          hintText: 'Confirm your password',
                          controller: _confirmPasswordController,
                          leadingIcon: Icons.lock_outline_rounded,
                          obscureText: state.obscureConfirmPassword,
                          onChanged: (value) {
                            context.read<SignupSigninBloc>().add(
                              SignupSigninConfirmPasswordChanged(value),
                            );
                          },
                          errorText: state.confirmPasswordError,
                          trailing: IconButton(
                            onPressed: () {
                              context.read<SignupSigninBloc>().add(
                                const SignupSigninConfirmPasswordVisibilityToggled(),
                              );
                            },
                            icon: Icon(
                              state.obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            children: <InlineSpan>[
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...<Widget>[
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 28,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: state.rememberMe,
                                  onChanged: (_) {
                                    context.read<SignupSigninBloc>().add(
                                      const SignupSigninRememberMeToggled(),
                                    );
                                  },
                                  side: const BorderSide(
                                    color: AppColors.border,
                                    width: 1.1,
                                  ),
                                  activeColor: AppColors.primary,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember me',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _openForgotPasswordDialog(context),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot password?',
                                  style: AppTextStyles.body2.copyWith(
                                    color: AppColors.primary,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (state.errorMessage != null &&
                          state.currentRequest !=
                              SignupSigninRequest.forgotPassword) ...<Widget>[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0EF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            state.errorMessage!,
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      AuthPrimaryButton(
                        height: 55.98,
                        label: isSignUp ? 'Create Account' : 'Sign In',
                        isLoading: isSubmitting,
                        onTap: () {
                          context.read<SignupSigninBloc>().add(
                            isSignUp
                                ? const SignupSigninSignUpSubmitted()
                                : const SignupSigninSignInSubmitted(),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text(
                              isSignUp
                                  ? 'Already have an account? '
                                  : "Don't have an account? ",
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _switchMode(
                                  context,
                                  isSignUp
                                      ? SignupSigninMode.signIn
                                      : SignupSigninMode.signUp,
                                );
                              },
                              child: Text(
                                isSignUp ? 'Sign in' : 'Sign up',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            child: Divider(color: AppColors.border),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              isSignUp ? 'or' : 'or continue with',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: AppColors.border),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          SocialAuthButton(
                            label: 'Google',
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF3F3D56),
                            leading: const _GoogleMark(size: 20),
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          const SocialAuthButton(
                            label: 'Facebook',
                            backgroundColor: Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            leading: Icon(
                              Icons.facebook_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            boxShadow: <BoxShadow>[],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _validationIcon({required bool show}) {
    if (!show) {
      return const SizedBox(width: 20, height: 20);
    }

    return const Padding(
      padding: EdgeInsets.only(right: 16),
      child: Icon(
        Icons.check_circle_outline_rounded,
        color: AppColors.success,
        size: 20,
      ),
    );
  }

  void _switchMode(BuildContext context, SignupSigninMode mode) {
    final bool toSignUp = mode == SignupSigninMode.signUp;
    final bloc = context.read<SignupSigninBloc>();

    _fullNameController.text = '';
    _emailController.text = toSignUp ? '' : 'demo@placepals.com';
    _passwordController.text = toSignUp ? '' : 'password123';
    _confirmPasswordController.text = '';

    bloc.add(SignupSigninModeChanged(mode: mode, clearSensitive: true));
    bloc.add(SignupSigninFullNameChanged(_fullNameController.text));
    bloc.add(SignupSigninEmailChanged(_emailController.text));
    bloc.add(SignupSigninPasswordChanged(_passwordController.text));
    bloc.add(SignupSigninConfirmPasswordChanged(_confirmPasswordController.text));
  }

  void _openForgotPasswordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SignupSigninBloc>(),
          child: const ForgotPasswordDialog(),
        );
      },
    );
  }

  void _syncControllers(SignupSigninState state) {
    if (_fullNameController.text != state.fullName) {
      _fullNameController.text = state.fullName;
    }
    if (_emailController.text != state.email) {
      _emailController.text = state.email;
    }
    if (_passwordController.text != state.password) {
      _passwordController.text = state.password;
    }
    if (_confirmPasswordController.text != state.confirmPassword) {
      _confirmPasswordController.text = state.confirmPassword;
    }
  }
}






class _GoogleMark extends StatelessWidget {
  final double size;

  const _GoogleMark({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _GoogleMarkPainter(),
    );
  }
}

class _GoogleMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.width * 0.18;
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    void drawSegment(Color color, double startDeg, double sweepDeg) {
      final Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        _deg(startDeg),
        _deg(sweepDeg),
        false,
        paint,
      );
    }

    drawSegment(const Color(0xFFEA4335), -42, 84);
    drawSegment(const Color(0xFFFBBC05), 44, 86);
    drawSegment(const Color(0xFF34A853), 132, 92);
    drawSegment(const Color(0xFF4285F4), 224, 94);

    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double centerY = size.height * 0.52;
    canvas.drawLine(
      Offset(size.width * 0.54, centerY),
      Offset(size.width * 0.88, centerY),
      barPaint,
    );
  }

  double _deg(double degrees) => degrees * (math.pi / 180);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



