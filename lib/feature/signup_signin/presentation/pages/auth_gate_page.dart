import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../bottom_appbar/presentation/pages/bottom_appbar_page.dart';
import 'email_verification_pending_page.dart';
import 'welcome_page.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<FirebaseAuthService>();

    return StreamBuilder<User?>(
      stream: authService.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _AuthGateLoadingView();
        }

        final user = snapshot.data;
        if (user == null) {
          return const WelcomePage();
        }

        if (!user.emailVerified) {
          return EmailVerificationPendingPage(email: user.email ?? '');
        }

        return const BottomAppBarPage();
      },
    );
  }
}

class _AuthGateLoadingView extends StatelessWidget {
  const _AuthGateLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }
}
