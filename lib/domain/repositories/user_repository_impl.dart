import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';

class UserRepositoryImpl extends UserRepository {
  final Logger _logger;
  final FirebaseAuth _fa;
  final FirebaseFirestore _db;
  final HandleErrorsRepository _he;

  UserRepositoryImpl(
    this._logger,
    this._fa,
    this._db,
    this._he,
  );

  @override
  Future<User?> getFirebaseUser() async {
    try {
      await _fa.currentUser!.reload();
      return _fa.currentUser;
    } catch (e, s) {
      await _he.handleError(
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
      await _he.handleError(
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
      ).doc(user.id!).set(user.toJson()).then((value) async {
          return await getUser(user.id!);
        },
      );
    } catch (e, s) {
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'editUserData',
      );
      return false;
    }
  }
}
