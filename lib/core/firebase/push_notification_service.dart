import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';
import '../utils/app_logger.dart';
import 'firebase_auth_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) {}

class PushNotificationService {
  static const String welcomeChannelId = 'welcome_messages';
  static const String _androidChannelName = 'Welcome messages';
  static const String _androidChannelDescription =
      'Notifications shown after a successful sign-in.';
  static const String _androidNotificationIcon = 'ic_stat_welcome';
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        welcomeChannelId,
        _androidChannelName,
        description: _androidChannelDescription,
        importance: Importance.max,
      );
  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
        welcomeChannelId,
        _androidChannelName,
        channelDescription: _androidChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        icon: _androidNotificationIcon,
        color: Color(0xFFFF6B5A),
      );

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore;
  final AppLogger _logger;

  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;
  StreamSubscription<String>? _onTokenRefreshSubscription;
  bool _initialized = false;

  PushNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    FirebaseAuthService? authService,
    FirebaseFirestore? firestore,
    AppLogger? logger,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin(),
       _authService = authService ?? FirebaseAuthService(),
       _firestore = firestore ?? FirebaseFirestore.instance,
       _logger = logger ?? AppLogger();

  Future<void> initialize() async {
    if (_initialized || !_isAndroidPlatform) {
      return;
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    const settings = InitializationSettings(
      android: AndroidInitializationSettings(_androidNotificationIcon),
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleLocalNotificationTap,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    _onMessageSubscription = FirebaseMessaging.onMessage.listen((message) {
      unawaited(_handleForegroundMessage(message));
    });
    _onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen(_handleRemoteMessageTap);
    _onTokenRefreshSubscription = _messaging.onTokenRefresh.listen((token) {
      unawaited(_handleTokenRefresh(token));
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleRemoteMessageTap(initialMessage);
    }

    _initialized = true;
  }

  Future<void> dispose() async {
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedAppSubscription?.cancel();
    await _onTokenRefreshSubscription?.cancel();
    _onMessageSubscription = null;
    _onMessageOpenedAppSubscription = null;
    _onTokenRefreshSubscription = null;
    _initialized = false;
  }

  Future<bool> requestPermissionIfNeeded() async {
    if (!_isAndroidPlatform) {
      return false;
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<String?> syncCurrentUserToken({bool updateLastLoginAt = false}) async {
    if (!_isAndroidPlatform) {
      return null;
    }

    final user = _authService.currentUser;
    if (user == null) {
      return null;
    }

    final token = await _messaging.getToken();
    if (token == null || token.isEmpty) {
      _logger.warn('FCM token unavailable for current user ${user.uid}.');
      return null;
    }

    final payload = <String, dynamic>{
      'androidFcmToken': token,
      'androidFcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (updateLastLoginAt) {
      payload['lastLoginAt'] = FieldValue.serverTimestamp();
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(payload, SetOptions(merge: true));

    return token;
  }

  Future<void> detachCurrentTokenFromCurrentUser() async {
    if (!_isAndroidPlatform) {
      return;
    }

    final user = _authService.currentUser;
    if (user == null) {
      return;
    }

    try {
      await _firestore.collection('users').doc(user.uid).set(<String, dynamic>{
        'androidFcmToken': null,
        'androidFcmTokenUpdatedAt': null,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (error, stackTrace) {
      _logger.error(
        'Failed to detach FCM token for user ${user.uid}.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  bool get _isAndroidPlatform =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (!_isAndroidPlatform) {
      return;
    }

    final title =
        message.notification?.title ?? message.data['title'] as String?;
    final body = message.notification?.body ?? message.data['body'] as String?;

    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      return;
    }

    await _localNotifications.show(
      message.messageId?.hashCode ??
          DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
      title,
      body,
      const NotificationDetails(android: _androidNotificationDetails),
      payload: jsonEncode(message.data),
    );
  }

  void _handleLocalNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) {
      _logger.info('Local notification tapped.');
      return;
    }

    _logger.info('Local notification tapped with payload $payload.');
  }

  void _handleRemoteMessageTap(RemoteMessage message) {
    _logger.info(
      'Remote notification tapped: ${message.data['type'] ?? 'unknown'}.',
    );
  }

  Future<void> _handleTokenRefresh(String token) async {
    final user = _authService.currentUser;
    if (user == null || token.isEmpty) {
      return;
    }

    try {
      await _firestore.collection('users').doc(user.uid).set(<String, dynamic>{
        'androidFcmToken': token,
        'androidFcmTokenUpdatedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (error, stackTrace) {
      _logger.error(
        'Failed to sync refreshed FCM token for user ${user.uid}.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
