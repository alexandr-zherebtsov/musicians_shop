import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/local/preference_manager.dart';
import 'package:musicians_shop/data/models/fcm_tocken_model.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/shared/utils/notifications.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

/// listeners initialized only once in app
bool listenersAreNotInitialized = true;

abstract interface class IPushNotificationDataProvider
    extends BaseDataProvider {
  Future<bool> initializePN();

  Future<void> setFcmToken({
    required final String? newToken,
    required final String? oldToken,
  });

  Future<void> removeFcmToken();

  Future<String?> getFcmToken();

  Future<void> deleteFcmToken();
}

class PushNotificationDataProvider extends IPushNotificationDataProvider {
  PushNotificationDataProvider({
    required final Logger logger,
    required final FirebaseAuth auth,
    required final FirebaseMessaging messaging,
    required final IUserRepository userRepository,
    required final IPreferenceManager pref,
    required final IHandleErrorsRepository errorHandler,
  })  : _logger = logger,
        _auth = auth,
        _messaging = messaging,
        _userRepository = userRepository,
        _pref = pref,
        _errorHandler = errorHandler;

  final Logger _logger;
  final FirebaseAuth _auth;
  final FirebaseMessaging _messaging;
  final IUserRepository _userRepository;
  final IPreferenceManager _pref;
  final IHandleErrorsRepository _errorHandler;

  @override
  Future<bool> initializePN() async {
    try {
      await AppNotifications.init();
      await _requestPermission();
      await _setForegroundNotificationPresentation();
      await _setAutoInitEnabled();
      await _getToken();
      await _initListeners();
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'initializePN',
      );
      return false;
    }
  }

  Future<NotificationSettings?> _requestPermission() async {
    try {
      return await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'requestPermission',
      );
      return null;
    }
  }

  Future<void> _setForegroundNotificationPresentation() async {
    try {
      await _messaging.setForegroundNotificationPresentationOptions(
        badge: true,
        sound: true,
        alert: true,
      );
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'setForegroundNotificationPresentation',
      );
    }
  }

  Future<void> _setAutoInitEnabled() async {
    try {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'setAutoInitEnabled',
      );
    }
  }

  Future<void> _getToken() async {
    try {
      String? oldToken;
      final String? fcmToken = await getFcmToken();
      final String prefToken = await _pref.getFcmToken();

      if (prefToken.isEmpty) {
        await _pref.setFcmToken(fcmToken);
      } else if (fcmToken != prefToken) {
        oldToken = prefToken;
      }

      _logger.d({
        'FCM Token': fcmToken,
        'Pref Token': prefToken,
      });

      await setFcmToken(
        newToken: fcmToken,
        oldToken: oldToken,
      );
    } catch (e, s) {
      if (e is FirebaseException) {
        if (e.code == 'permission-blocked') {
          final String token = await _pref.getFcmToken();
          setFcmToken(
            oldToken: token.isEmpty ? null : token,
          );
        }
      }
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getToken',
      );
    }
  }

  Future<void> _initListeners() async {
    try {
      if (listenersAreNotInitialized) {
        listenersAreNotInitialized = false;
        FirebaseMessaging.onMessage.listen((final RemoteMessage message) {
          _log('onMessage: ${message.notification?.toMap()}');
          AppNotifications.showPush(message);
        });
        FirebaseMessaging.onMessageOpenedApp
            .listen((final RemoteMessage message) {
          _log('onMessageOpenedApp: ${message.notification}');
        });
        FirebaseMessaging.onBackgroundMessage(
            (final RemoteMessage message) async {
          _log('onBackgroundMessage: ${message.notification}');
        });
      }
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'initListeners',
      );
    }
  }

  @override
  Future<void> setFcmToken({
    final String? newToken,
    final String? oldToken,
  }) async {
    try {
      if (newToken != null || oldToken != null) {
        final String? uid = _auth.currentUser?.uid;
        UserModel? user;
        if (uid != null) {
          user = await _userRepository.getUser(uid);
          if (user != null) {
            if (newToken != null) {
              final FcmTokenModel tokenModel = FcmTokenModel(
                token: newToken,
                platform: MainUtils.getCurrentPlatform,
                os: MainUtils.getCurrentOS,
              );
              final Timestamp now = Timestamp.now();
              if ((user.fcmTokens ?? []).isEmpty) {
                user.fcmTokens = <FcmTokenModel>[
                  tokenModel.copyWith(
                    createdAt: now,
                    updatedAt: now,
                  ),
                ];
              } else {
                final FcmTokenModel? containedToken =
                    user.fcmTokens?.firstWhereOrNull(
                  (e) => e.token == newToken,
                );
                if (containedToken != null) {
                  user.fcmTokens?.removeWhere((e) => e.token == newToken);
                  user.fcmTokens = <FcmTokenModel>[
                    ...user.fcmTokens!,
                    tokenModel.copyWith(
                      createdAt: containedToken.createdAt,
                      updatedAt: now,
                    ),
                  ];
                } else {
                  user.fcmTokens = <FcmTokenModel>[
                    ...user.fcmTokens!,
                    tokenModel.copyWith(
                      createdAt: now,
                      updatedAt: now,
                    ),
                  ];
                }
                user.fcmTokens?.removeWhere(
                  (e) {
                    if (e.updatedAt != null) {
                      final DateTime date = e.updatedAt!.toDate();
                      final Duration diff = date.difference(now.toDate());
                      return (diff.inDays * -1) >= 31;
                    } else {
                      return true;
                    }
                  },
                );
              }
            }
            if (oldToken != null && user.fcmTokens != null) {
              user.fcmTokens?.removeWhere(
                (e) => e.token == oldToken,
              );
            }
            await _userRepository.editUserData(user);
          }
        }
      }
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'setFcmToken',
      );
    }
  }

  @override
  Future<void> removeFcmToken() async {
    try {
      final String? token = await getFcmToken();
      if (token != null) {
        final String? uid = _auth.currentUser?.uid;
        if (uid != null) {
          final UserModel? user = await _userRepository.getUser(uid);
          if ((user?.fcmTokens ?? []).isNotEmpty) {
            user?.fcmTokens?.removeWhere((e) => e.token == token);
            await _userRepository.editUserData(user!);
          }
        }
        await deleteFcmToken();
      }
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'removeFcmToken',
      );
    }
  }

  @override
  Future<String?> getFcmToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      _log(e);
      return null;
    }
  }

  @override
  Future<void> deleteFcmToken() async {
    try {
      await _messaging.deleteToken();
    } catch (e) {
      _log(e);
    }
  }

  void _log(final dynamic value) {
    log(value.toString(), name: 'PushNotificationRepository');
  }
}
