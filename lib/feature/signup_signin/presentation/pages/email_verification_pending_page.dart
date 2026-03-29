import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import 'auth_gate_page.dart';

class EmailVerificationPendingPage extends StatefulWidget {
  final String email;

  const EmailVerificationPendingPage({super.key, required this.email});

  @override
  State<EmailVerificationPendingPage> createState() =>
      _EmailVerificationPendingPageState();
}

class _EmailVerificationPendingPageState
    extends State<EmailVerificationPendingPage> {
  late final FirebaseAuthService _authService;
  bool _isReloading = false;
  bool _isResending = false;
  bool _isSigningOut = false;
  String? _message;
  bool _isErrorMessage = false;

  @override
  void initState() {
    super.initState();
    _authService = getIt<FirebaseAuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const AuthLogo(),
                  const SizedBox(height: 28),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_outlined,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Verify your email',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We sent a verification link to ${widget.email.isEmpty ? 'your inbox' : widget.email}. '
                    'Open the email, confirm your account, then come back here.',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Email verification is required before you can use the app.',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'If you do not see the email, check your spam folder or resend the verification message.',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_message != null) ...<Widget>[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _isErrorMessage
                            ? const Color(0xFFFFF0EF)
                            : const Color(0xFFF2FFF4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _message!,
                        style: AppTextStyles.body2.copyWith(
                          color: _isErrorMessage
                              ? AppColors.error
                              : AppColors.success,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  AuthPrimaryButton(
                    label: 'I have verified my email',
                    leadingIcon: Icons.verified_outlined,
                    isLoading: _isReloading,
                    onTap: _handleReloadVerification,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: _isResending
                          ? null
                          : _handleResendVerification,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: _isResending
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: AppColors.primary,
                              ),
                            )
                          : Text(
                              'Resend verification email',
                              style: AppTextStyles.heading3.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    child: TextButton(
                      onPressed: _isSigningOut
                          ? null
                          : _handleUseAnotherAccount,
                      child: _isSigningOut
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            )
                          : Text(
                              'Use a different account',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleReloadVerification() async {
    setState(() {
      _isReloading = true;
      _message = null;
    });

    try {
      await _authService.reloadCurrentUser();
      final currentUser = _authService.currentUser;
      if (!mounted) return;

      if (currentUser != null && currentUser.emailVerified) {
        setState(() {
          _isErrorMessage = false;
          _message = 'Email verified. Redirecting you into PlacePals.';
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const AuthGatePage()),
          (route) => false,
        );
        return;
      }

      setState(() {
        _isErrorMessage = true;
        _message =
            'Your email is not verified yet. Please open the verification email and try again.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isErrorMessage = true;
        _message = 'Unable to refresh verification status right now.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isReloading = false;
        });
      }
    }
  }

  Future<void> _handleResendVerification() async {
    setState(() {
      _isResending = true;
      _message = null;
    });

    try {
      await _authService.sendEmailVerification();
      if (!mounted) return;
      setState(() {
        _isErrorMessage = false;
        _message = 'A new verification email has been sent.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isErrorMessage = true;
        _message = 'Unable to resend the verification email right now.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  Future<void> _handleUseAnotherAccount() async {
    setState(() {
      _isSigningOut = true;
      _message = null;
    });

    try {
      await _authService.signOut();
    } finally {
      if (mounted) {
        setState(() {
          _isSigningOut = false;
        });
      }
    }
  }
}
