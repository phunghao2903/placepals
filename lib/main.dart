import 'package:flutter/material.dart';
import 'package:placepals/core/core.dart';
import 'package:placepals/feature/bottom_appbar/presentation/pages/bottom_appbar_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const BottomAppBarPage(),
    );
  }
}
