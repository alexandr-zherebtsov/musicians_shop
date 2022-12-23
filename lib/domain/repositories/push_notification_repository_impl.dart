import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/push_notification_repository.dart';
import 'package:musicians_shop/shared/utils/notifications.dart';

class PushNotificationRepositoryImpl extends PushNotificationRepository {
  final Logger _logger;
  final FirebaseMessaging _fms;
  final HandleErrorsRepository _he;

  PushNotificationRepositoryImpl(
    this._logger,
    this._fms,
    this._he,
  );

  @override
  Future<bool> initializePN() async {
    try {
      await AppNotifications.init();
      await _fms.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await _fms.setForegroundNotificationPresentationOptions(
        badge: true,
        sound: true,
        alert: true,
      );
      final String? token = await _fms.getToken();
      _logger.d({'FCM Token': token});
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        AppNotifications.showPush(message);
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AppNotifications.showPush(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        AppNotifications.showPush(message);
      });
      return true;
    } catch (e, s) {
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'initializePN',
      );
      return false;
    }
  }
}
