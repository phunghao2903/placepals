import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/signup_signin_bloc.dart';
import 'auth_input_field.dart';
import 'auth_primary_button.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: BlocBuilder<SignupSigninBloc, SignupSigninState>(
          builder: (context, state) {
            final isLoading =
                state.status == SignupSigninStatus.loading &&
                state.currentRequest == SignupSigninRequest.forgotPassword;
            final errorText =
                state.currentRequest == SignupSigninRequest.forgotPassword &&
                    state.status == SignupSigninStatus.failure
                ? state.errorMessage
                : null;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF897B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Reset Password',
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter your email and we'll send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 20),
                AuthInputField(
                  label: 'Email Address',
                  hintText: 'email@example.com',
                  controller: _emailController,
                  leadingIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) {
                    if (state.currentRequest ==
                            SignupSigninRequest.forgotPassword &&
                        state.status == SignupSigninStatus.failure) {
                      context.read<SignupSigninBloc>().add(
                        const SignupSigninActionCleared(),
                      );
                    }
                  },
                  errorText: errorText,
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AuthPrimaryButton(
                        label: 'Send Link',
                        isLoading: isLoading,
                        onTap: () {
                          context.read<SignupSigninBloc>().add(
                            SignupSigninForgotPasswordSubmitted(
                              email: _emailController.text,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
