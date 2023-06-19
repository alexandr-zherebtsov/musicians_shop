import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:universal_html/js.dart' as js;

class AppNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const DarwinInitializationSettings initializationSettingsApple =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: false,
    requestAlertPermission: true,
  );

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
    AppValues.androidNotificationIcon,
  );

  static const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsApple,
    macOS: initializationSettingsApple,
  );

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    AppValues.androidNotificationChannelId,
    AppValues.androidNotificationChannelName,
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> init() async {
    if (!kIsWeb) {
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  static void _onDidReceiveNotificationResponse(
    final NotificationResponse notification,
  ) {
    //
  }

  static void _onDidReceiveBackgroundNotificationResponse(
    final NotificationResponse notification,
  ) {
    //
  }

  static showPush(final RemoteMessage? message) {
    if (message?.notification != null) {
      if (kIsWeb) {
        showSimpleNotification(
          Text(
            message?.notification?.body ?? '',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          background: Colors.white,
        );
        js.context.callMethod('playNotificationSound');
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        flutterLocalNotificationsPlugin.show(
          message!.notification.hashCode,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.black,
              playSound: true,
              importance: Importance.max,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentSound: true,
            ),
          ),
        );
      }
      Get.find<Logger>().d(message?.notification?.body);
    }
  }
}
