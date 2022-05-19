import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource _remoteDataSource;
  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.signInEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> registerEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.registerEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    return await _remoteDataSource.logOut();
  }

  @override
  Future<bool> deleteUser() async {
    return await _remoteDataSource.deleteUser();
  }
}
