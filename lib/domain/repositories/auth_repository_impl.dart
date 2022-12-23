import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/remote/auth_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _fa;
  final FirebaseAnalytics _fan;
  final HandleErrorsRepository _he;

  AuthRepositoryImpl(
    this._fa,
    this._fan,
    this._he,
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
    } catch (e, s) {
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
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
      await _he.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteUser',
      );
      return false;
    }
  }
}
