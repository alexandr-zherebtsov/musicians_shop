import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteDataSource _remoteDataSource;
  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> getFirebaseUser() async {
    return await _remoteDataSource.getFirebaseUser();
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    return await _remoteDataSource.getUser(uid);
  }

  @override
  Future<UserModel?> createUser(UserModel user) async {
    return await _remoteDataSource.createUser(user);
  }

  @override
  Future<bool> deleteUserData(String id) async {
    return await _remoteDataSource.deleteUserData(id);
  }

  @override
  Future<bool> editUserData(UserModel user) async {
    return await _remoteDataSource.editUserData(user);
  }
}
