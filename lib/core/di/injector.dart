import 'package:get_it/get_it.dart';

import '../../feature/bottom_appbar/bottom_appbar_injection.dart';
import '../../feature/home/home_injection.dart';
import '../services/time_provider.dart';
import '../utils/app_logger.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  _registerCore();
  await _registerFeatures();
}

void _registerCore() {
  getIt.registerLazySingleton<AppLogger>(AppLogger.new);
  getIt.registerLazySingleton<TimeProvider>(SystemTimeProvider.new);
}

Future<void> _registerFeatures() async {
  registerBottomAppBarDependencies(getIt);
  registerHomeDependencies(getIt);
}
