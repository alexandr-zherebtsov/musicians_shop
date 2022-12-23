import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/adverts_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';

class AdvertsRepositoryImpl extends AdvertsRepository {
  final Logger _logger;
  final FirebaseFirestore _db;
  final FirebaseAnalytics _fan;
  final HandleErrorsRepository _he;

  AdvertsRepositoryImpl(
    this._logger,
    this._db,
    this._fan,
    this._he,
  );

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
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'getLikedAdverts',
      );
      return <AdvertModel>[];
    }
  }
}
