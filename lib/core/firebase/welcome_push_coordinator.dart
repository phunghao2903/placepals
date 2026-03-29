import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';

import '../utils/app_logger.dart';
import 'firebase_auth_service.dart';
import 'push_notification_service.dart';

class WelcomePushCoordinator {
  static const String _functionsRegion = 'asia-southeast1';

  final PushNotificationService _pushNotificationService;
  final FirebaseAuthService _authService;
  final FirebaseFunctions _functions;
  final AppLogger _logger;

  WelcomePushCoordinator({
    PushNotificationService? pushNotificationService,
    FirebaseAuthService? authService,
    FirebaseFunctions? functions,
    AppLogger? logger,
  }) : _pushNotificationService =
           pushNotificationService ?? PushNotificationService(),
       _authService = authService ?? FirebaseAuthService(),
       _functions =
           functions ?? FirebaseFunctions.instanceFor(region: _functionsRegion),
       _logger = logger ?? AppLogger();

  Future<void> triggerAfterLogin() async {
    final user = _authService.currentUser;
    if (user == null) {
      return;
    }

    try {
      await _authService.markCurrentUserLogin();

      final permissionGranted = await _pushNotificationService
          .requestPermissionIfNeeded();
      if (!permissionGranted) {
        _logger.warn(
          'Notification permission denied after sign-in for user ${user.uid}.',
        );
        return;
      }

      final token = await _pushNotificationService.syncCurrentUserToken();
      if (token == null) {
        return;
      }

      final callable = _functions.httpsCallable(
        'sendWelcomePushOnLogin',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 15)),
      );

      await callable.call(<String, dynamic>{
        'loginEventId': _createLoginEventId(),
        'token': token,
      });
    } on FirebaseFunctionsException catch (error, stackTrace) {
      _logger.error(
        'Failed to trigger welcome push function: ${error.code}.',
        error: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      _logger.error(
        'Failed to complete welcome push login flow.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _createLoginEventId() {
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    final randomSuffix = Random.secure().nextInt(0x7fffffff).toRadixString(16);
    return 'login_${timestamp}_$randomSuffix';
  }
}
