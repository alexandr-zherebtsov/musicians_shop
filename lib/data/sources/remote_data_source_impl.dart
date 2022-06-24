import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/notifications.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final Logger _logger;
  final FirebaseAuth _fa;
  final FirebaseStorage _fs;
  final FirebaseFirestore _db;
  final FirebaseMessaging _fms;
  final FirebaseAnalytics _fan;
  final FirebaseCrashlytics _fcr;

  RemoteDataSourceImpl(
    this._logger,
    this._fa,
    this._fs,
    this._db,
    this._fms,
    this._fan,
    this._fcr,
  );

  @override
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
     await _fa.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     return true;
    }
    catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'signInEmailPassword',
      );
      return false;
    }
  }

  @override
  Future<User?> registerEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential res = await _fa.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _fan.logEvent(
        name: 'register_with_email_and_password',
        parameters: {
          'uid': res.user?.uid,
          'email': res.user?.email,
        },
      );
      return res.user;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'registerEmailPassword',
      );
      return null;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      await _fa.signOut();
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'logOut',
      );
      return false;
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await _fan.logEvent(
        name: 'delete_user',
        parameters: {
          'uid': _fa.currentUser?.uid,
          'email': _fa.currentUser?.email,
        },
      );
      await _fa.currentUser!.delete();
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'deleteUser',
      );
      return false;
    }
  }

  @override
  Future<User?> getFirebaseUser() async {
    try {
      await _fa.currentUser!.reload();
      return _fa.currentUser;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getFirebaseUser',
      );
      return null;
    }
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    try {
      return await _db.collection(
        AppValues.collectionUsers,
      ).doc(uid).get().then((DocumentSnapshot snapshot) {
        final Object? res = snapshot.data();
        if (res != null) {
          _logger.d(res);
          return UserModel.fromJson(res as Map<String, dynamic>);
        } else {
          return null;
        }
      });
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getUser',
      );
      return null;
    }
  }

  @override
  Future<UserModel?> createUser(UserModel user) async {
    try {
      return await _db.collection(
        AppValues.collectionUsers,
      ).doc(user.id!).set(user.toJson()).then(
        (value) async {
          return await getUser(user.id!);
        },
      );
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'createUser',
      );
      return null;
    }
  }

  @override
  Future<bool> deleteUserData(String id) async {
    try {
      await _db.collection(
        AppValues.collectionUsers,
      ).doc(id).delete();
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'deleteUserData',
      );
      return false;
    }
  }

  @override
  Future<bool> editUserData(UserModel user) async {
    try {
      await _db.collection(
        AppValues.collectionUsers,
      ).doc(user.id).update(user.toJson());
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'editUserData',
      );
      return false;
    }
  }

  @override
  Future<String?> uploadFile({
    required PlatformFile file,
    required FileTypeEnums type,
  }) async {
    try {
      if (kIsWeb) {
        String? imgUrl;
        final Reference ref = _fs.ref().child(getFileUrl(type) + getFileFormatFromString(
          file.name,
          dot: true,
        ));
        await ref.putData(
          file.bytes!,
          SettableMetadata(
            contentType: getFileType(
              fileName: file.name,
              type: type,
            ),
          ),
        ).whenComplete(() async {
          await ref.getDownloadURL().then((String v) {
            imgUrl = v;
          });
        });
        return imgUrl;
      } else {
        final UploadTask ut = _fs.ref().child(
          getFileUrl(type) + getFileFormatFromFile(
            path: file.path!,
            name: file.name,
            dot: true,
          ),
        ).putFile(File(file.path!));
        final String imgUrl = await(await ut).ref.getDownloadURL();
        return imgUrl;
      }
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'uploadFile',
      );
      return null;
    }
  }

  @override
  Future<bool> deleteFile(String fileUrl) async {
    try {
      await _fs.refFromURL(fileUrl).delete();
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'deleteFile',
      );
      return false;
    }
  }

  @override
  Future<List<AdvertModel>> getAdverts() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getAdverts',
      );
      return <AdvertModel>[];
    }
  }

  @override
  Future<bool> createAdvert(AdvertModel advert) async {
    try {
      await _db.collection(
        AppValues.collectionAdverts,
      ).doc(advert.id).set(advert.toJson());
      await _fan.logEvent(
        name: 'create_advert',
        parameters: {
          'id': advert.id,
          'uid': advert.uid,
          'headline': advert.headline,
          'type': advert.type?.type,
        },
      );
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'createAdvert',
      );
      return false;
    }
  }

  @override
  Future<bool> editAdvert(AdvertModel advert) async {
    try {
      await _db.collection(
        AppValues.collectionAdverts,
      ).doc(advert.id).update(advert.toJson());
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'editAdvert',
      );
      return false;
    }
  }

  @override
  Future<bool> deleteAdvert(String id) async {
    try {
      await _db.collection(
        AppValues.collectionAdverts,
      ).doc(id).delete();
      await _fan.logEvent(
        name: 'delete_advert',
        parameters: {
          'id': id,
        },
      );
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'deleteAdvert',
      );
      return false;
    }
  }

  @override
  Future<List<AdvertModel>> getMyAdverts(String uid) async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).where(
        'uid',
        isEqualTo: uid,
      ).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getMyAdverts',
      );
      return <AdvertModel>[];
    }
  }

  @override
  Future<List<AdvertModel>> getLikedAdverts(String uid) async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).where(
        'likes',
        arrayContains: uid,
      ).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getLikedAdverts',
      );
      return <AdvertModel>[];
    }
  }

  @override
  Future<List<InstrumentTypeModel>> getInstrumentTypes() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionInstrumentTypes,
      ).orderBy('type').get();
      final List<InstrumentTypeModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return InstrumentTypeModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final InstrumentTypeModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getInstrumentTypes',
      );
      return <InstrumentTypeModel>[];
    }
  }

  @override
  Future<bool> createInstrumentType(InstrumentTypeModel type) async {
    try {
      await _db.collection(
        AppValues.collectionInstrumentTypes,
      ).doc(type.id).set(type.toJson());
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'createInstrumentType',
      );
      return false;
    }
  }

  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionBrands,
      ).orderBy('name').get();
      final List<BrandModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return BrandModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      final BrandModel other = res.firstWhere((v) => v.id == '0');
      res.removeWhere((v) => v.id == '0');
      res.add(other);
      return res;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'getBrands',
      );
      return <BrandModel>[];
    }
  }

  @override
  Future<bool> createBrand(BrandModel brand) async {
    try {
      await _db.collection(
        AppValues.collectionBrands,
      ).doc(brand.id).set(brand.toJson());
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'createBrand',
      );
      return false;
    }
  }

  @override
  Future<bool> initializePN() async {
    try {
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
      _logger.d({'FM Token': token});
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        log('onBackgroundMessage');
        AppNotifications.showPush(message);
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('onMessage');
        AppNotifications.showPush(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('onMessageOpenedApp');
        AppNotifications.showPush(message);
      });
      return true;
    } catch (e, s) {
      await _onError(
        error: e,
        stackTrace: s,
        name: 'initializePN',
      );
      return false;
    }
  }

  Future<void> _onError({
    required Object error,
    required StackTrace stackTrace,
    required String name,
  }) async {
    log(
      error.toString(),
      name: 'error: $name',
      stackTrace: stackTrace,
    );
    if (!kIsWeb) {
      await _fcr.recordError(
        name,
        stackTrace,
        reason: name,
      );
    }
  }
}
