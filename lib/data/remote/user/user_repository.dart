import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/base/base_repository.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/user/user_data_provider.dart';

abstract interface class IUserRepository extends BaseRepository {
  Future<User?> getFirebaseUser();

  Future<UserModel?> getUser(final String uid);

  Future<UserModel?> createUser(final UserModel user);

  Future<bool> deleteUserData(final String id);

  Future<bool> editUserData(final UserModel user);
}

final class UserRepository implements IUserRepository {
  UserRepository({
    required final IUserDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final IUserDataProvider _dataProvider;

  @override
  Future<User?> getFirebaseUser() => _dataProvider.getFirebaseUser();

  @override
  Future<UserModel?> getUser(final String uid) => _dataProvider.getUser(uid);

  @override
  Future<UserModel?> createUser(final UserModel user) =>
      _dataProvider.createUser(user);

  @override
  Future<bool> deleteUserData(final String id) =>
      _dataProvider.deleteUserData(id);

  @override
  Future<bool> editUserData(final UserModel user) =>
      _dataProvider.editUserData(user);
}
