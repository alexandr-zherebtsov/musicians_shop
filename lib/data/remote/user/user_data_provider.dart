import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

abstract interface class IUserDataProvider extends BaseDataProvider {
  Future<User?> getFirebaseUser();

  Future<UserModel?> getUser(final String uid);

  Future<UserModel?> createUser(final UserModel user);

  Future<bool> deleteUserData(final String id);

  Future<bool> editUserData(final UserModel user);
}

class UserDataProvider implements IUserDataProvider {
  UserDataProvider({
    required final Logger logger,
    required final FirebaseAuth auth,
    required final FirebaseFirestore firestore,
    required final IHandleErrorsRepository errorHandler,
  })  : _logger = logger,
        _auth = auth,
        _firestore = firestore,
        _errorHandler = errorHandler;

  final Logger _logger;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final IHandleErrorsRepository _errorHandler;

  @override
  Future<User?> getFirebaseUser() async {
    try {
      await _auth.currentUser!.reload();
      return _auth.currentUser;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getFirebaseUser',
      );
      return null;
    }
  }

  @override
  Future<UserModel?> getUser(final String uid) async {
    try {
      return await _firestore
          .collection(
            AppValues.collectionUsers,
          )
          .doc(uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        final Object? res = snapshot.data();
        if (res != null) {
          _logger.d(res);
          return UserModel.fromJson(res as Map<String, dynamic>);
        } else {
          return null;
        }
      });
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'getUser',
      );
      return null;
    }
  }

  @override
  Future<UserModel?> createUser(final UserModel user) async {
    try {
      return await _firestore
          .collection(
            AppValues.collectionUsers,
          )
          .doc(user.id!)
          .set(user.toJson())
          .then(
        (value) async {
          return await getUser(user.id!);
        },
      );
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'createUser',
      );
      return null;
    }
  }

  @override
  Future<bool> deleteUserData(final String id) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionUsers,
          )
          .doc(id)
          .delete();
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteUserData',
      );
      return false;
    }
  }

  @override
  Future<bool> editUserData(final UserModel user) async {
    try {
      await _firestore
          .collection(
            AppValues.collectionUsers,
          )
          .doc(user.id)
          .update(user.toJson());
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'editUserData',
      );
      return false;
    }
  }
}
