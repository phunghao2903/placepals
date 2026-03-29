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
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: 341.91,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 50,
                offset: Offset(0, 25),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: BlocBuilder<SignupSigninBloc, SignupSigninState>(
              builder: (context, state) {
                final bool isLoading =
                    state.status == SignupSigninStatus.loading &&
                    state.currentRequest == SignupSigninRequest.forgotPassword;
                final String? errorText =
                    state.currentRequest == SignupSigninRequest.forgotPassword &&
                        state.status == SignupSigninStatus.failure
                    ? state.errorMessage
                    : null;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 63.98,
                      height: 63.98,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF897B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline_rounded,
                        size: 31.99,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading4.copyWith(
                        color: AppColors.textPrimary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your email and we'll send you a link to reset your password",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthInputField(
                      label: 'Email Address',
                      hintText: 'email@example.com',
                      controller: _emailController,
                      leadingIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      fieldHeight: 54.16,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 47.99,
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.textPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: AppTextStyles.heading3.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AuthPrimaryButton(
                            label: 'Send Link',
                            isLoading: isLoading,
                            height: 47.99,
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
        ),
      ),
    );
  }
}
