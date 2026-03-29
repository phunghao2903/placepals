import 'package:get_it/get_it.dart';

import '../../feature/ai_recommendation/ai_recommendation_injection.dart';
import '../../feature/bottom_appbar/bottom_appbar_injection.dart';
import '../../feature/create_moment/create_moment_injection.dart';
import '../../feature/home/home_injection.dart';
import '../../feature/map/map_injection.dart';
import '../../feature/place_details/appointment_injection.dart';
import '../../feature/notifications/notifications_injection.dart';
import '../../feature/profile/profile_injection.dart';
import '../../feature/savedlist/appointment_injection.dart';
import '../../feature/search/search_injection.dart';
import '../../feature/signup_signin/signup_signin_injection.dart';
import '../../feature/sos/sos_injection.dart';
import '../services/time_provider.dart';
import '../utils/app_logger.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  _registerCore();
  await _registerFeatures();
}

void _registerCore() {
  if (!getIt.isRegistered<AppLogger>()) {
    getIt.registerLazySingleton<AppLogger>(AppLogger.new);
  }
  if (!getIt.isRegistered<TimeProvider>()) {
    getIt.registerLazySingleton<TimeProvider>(SystemTimeProvider.new);
  }
}

Future<void> _registerFeatures() async {
  registerAiRecommendationDependencies(getIt);
  registerBottomAppBarDependencies(getIt);
  registerCreateMomentDependencies(getIt);
  registerHomeDependencies(getIt);
  registerMapDependencies(getIt);
  registerPlaceDetailsDependencies(getIt);
  registerNotificationsDependencies(getIt);
  registerProfileDependencies(getIt);
  registerSavedListDependencies(getIt);
  registerSearchDependencies(getIt);
  registerSignupSigninDependencies(getIt);
  registerSosDependencies(getIt);
}
