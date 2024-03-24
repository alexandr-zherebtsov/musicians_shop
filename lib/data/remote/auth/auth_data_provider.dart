import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/base/base_data_provider.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';

abstract interface class IAuthDataProvider extends BaseDataProvider {
  Future<bool> signInEmailPassword({
    required final String email,
    required final String password,
  });

  Future<User?> registerEmailPassword({
    required final String email,
    required final String password,
  });

  Future<void> logOut();

  Future<bool> deleteUser();
}

final class AuthDataProvider implements IAuthDataProvider {
  AuthDataProvider({
    required final FirebaseAuth auth,
    required final FirebaseAnalytics analytics,
    required final IHandleErrorsRepository errorHandler,
  })  : _auth = auth,
        _analytics = analytics,
        _errorHandler = errorHandler;

  final FirebaseAuth _auth;
  final FirebaseAnalytics _analytics;
  final IHandleErrorsRepository _errorHandler;

  @override
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
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
      final UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _analytics.logEvent(
        name: 'register_with_email_and_password',
        parameters: {
          'uid': res.user?.uid,
          'email': res.user?.email,
        },
      );
      return res.user;
    } catch (e, s) {
      await _errorHandler.handleError(
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
      await _auth.signOut();
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
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
      await _analytics.logEvent(
        name: 'delete_user',
        parameters: {
          'uid': _auth.currentUser?.uid,
          'email': _auth.currentUser?.email,
        },
      );
      await _auth.currentUser!.delete();
      return true;
    } catch (e, s) {
      await _errorHandler.handleError(
        error: e,
        stackTrace: s,
        name: 'deleteUser',
      );
      return false;
    }
  }
}
