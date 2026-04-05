import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:placepals/core/core.dart';
import 'package:placepals/core/firebase/push_notification_service.dart';
import 'package:placepals/feature/map/presentation/pages/map_page2.dart';
import 'package:placepals/feature/signup_signin/presentation/pages/splash_page.dart';
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
  try {
    await getIt<PushNotificationService>().initialize();
  } catch (error, stackTrace) {
    getIt<AppLogger>().error(
      'Push notification initialization failed.',
      error: error,
      stackTrace: stackTrace,
    );
  }
  assert(() {
    debugPaintBaselinesEnabled = false;
    return true;
  }());
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  await dotenv.load(fileName: ".env");
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_ACCESS_TOKEN']!);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    assert(() {
      debugPaintSizeEnabled = false;
      debugPaintBaselinesEnabled = false;
      debugPaintPointersEnabled = false;
      debugRepaintRainbowEnabled = false;
      return true;
    }());

    // return MaterialApp(
    //   title: AppConstants.appName,
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme.light(),
    //   home: const SplashPage(),
    // );
    return MapPage2();
  }
}
