import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:placepals/core/core.dart';
import 'package:placepals/feature/signup_signin/presentation/pages/auth_gate_page.dart';
import 'package:placepals/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("Firebase connected successfully");
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AuthGatePage(),
    );
  }
}
