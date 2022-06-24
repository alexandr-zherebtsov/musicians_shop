import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

class AppNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: false,
    requestAlertPermission: true,
  );

  static const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  static const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
    'mipmap/ic_launcher',
  );

  static const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
  );

  static init() {
    if (!kIsWeb) {
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (_) => flutterLocalNotificationsPlugin.cancelAll(),
      );
    }
  }

  static showPush(RemoteMessage message) {
    final RemoteNotification? notification = message.notification;
    if (notification != null) {
      if (!kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.black,
              playSound: true,
              importance: Importance.max,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const IOSNotificationDetails(
              presentAlert: true,
              presentSound: true,
            ),
          ),
          payload: 'Default_Sound',
        );
      } else {
        showSimpleNotification(
          Text(
            notification.body ?? '',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          background: Colors.white,
        );
      }
    }
  }
}
