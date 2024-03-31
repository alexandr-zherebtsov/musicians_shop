import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

abstract interface class IAdvertsDataProvider extends BaseDataProvider {
  Stream<QuerySnapshot<Object?>> get streamAdverts;

  Future<List<AdvertModel>> getAdverts();

  Future<bool> createAdvert(final AdvertModel advert);

  Future<bool> editAdvert(final AdvertModel advert);

  Future<bool> deleteAdvert(final String id);

  Future<List<AdvertModel>> getMyAdverts(final String uid);

  Future<List<AdvertModel>> getLikedAdverts(final String uid);
}

final class AdvertsDataProvider implements IAdvertsDataProvider {
  AdvertsDataProvider({
    required final Logger logger,
    required final FirebaseFirestore firestore,
    required final FirebaseAnalytics analytics,
    required final IHandleErrorsRepository errorHandler,
  })  : _logger = logger,
        _firestore = firestore,
        _analytics = analytics,
        _errorHandler = errorHandler;

  final Logger _logger;
  final FirebaseFirestore _firestore;
  final FirebaseAnalytics _analytics;
  final IHandleErrorsRepository _errorHandler;

  @override
  Stream<QuerySnapshot<Object?>> get streamAdverts {
    final CollectionReference ref = _firestore.collection(
      AppValues.collectionAdverts,
    );
    return ref.orderBy('updatedAt').snapshots();
  }

  @override
  Future<List<AdvertModel>> getAdverts() async {
    try {
      final QuerySnapshot qs = await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .orderBy('updatedAt')
          .get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getAdverts',
      );
      return <AdvertModel>[];
    }
  }

  @override
  Future<bool> createAdvert(final AdvertModel advert) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .doc(advert.id)
          .set(advert.toJson());
      await _analytics.logEvent(
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
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'createAdvert',
      );
      return false;
    }
  }

  @override
  Future<bool> editAdvert(final AdvertModel advert) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .doc(advert.id)
          .update(advert.toJson());
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'editAdvert',
      );
      return false;
    }
  }

  @override
  Future<bool> deleteAdvert(final String id) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .doc(id)
          .delete();
      await _analytics.logEvent(
        name: 'delete_advert',
        parameters: {
          'id': id,
        },
      );
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteAdvert',
      );
      return false;
    }
  }

  @override
  Future<List<AdvertModel>> getMyAdverts(final String uid) async {
    try {
      final QuerySnapshot qs = await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .where(
            'uid',
            isEqualTo: uid,
          )
          .orderBy('updatedAt')
          .get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getMyAdverts',
      );
      return <AdvertModel>[];
    }
  }

  @override
  Future<List<AdvertModel>> getLikedAdverts(final String uid) async {
    try {
      final QuerySnapshot qs = await _firestore
          .collection(
            AppValues.collectionAdverts,
          )
          .where(
            'likes',
            arrayContains: uid,
          )
          .orderBy('updatedAt')
          .get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        _logger.d(e.data());
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getLikedAdverts',
      );
      return <AdvertModel>[];
    }
  }
}
