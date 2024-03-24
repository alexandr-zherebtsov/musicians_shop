import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/remote/auth/auth_data_provider.dart';

abstract interface class IAuthRepository extends BaseRepository {
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

final class AuthRepository implements IAuthRepository {
  AuthRepository({
    required final IAuthDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IAuthDataProvider _dataProvider;

  @override
  Future<bool> signInEmailPassword({
    required final String email,
    required final String password,
  }) =>
      _dataProvider.signInEmailPassword(
        email: email,
        password: password,
      );

  @override
  Future<User?> registerEmailPassword({
    required final String email,
    required final String password,
  }) =>
      _dataProvider.registerEmailPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => _dataProvider.logOut();

  @override
  Future<bool> deleteUser() => _dataProvider.deleteUser();
}
