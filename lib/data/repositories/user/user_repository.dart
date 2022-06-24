import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class UserRepository extends BaseRepository {

  Future<User?> getFirebaseUser();

  Future<UserModel?> getUser(String uid);

  Future<UserModel?> createUser(UserModel user);

  Future<bool> deleteUserData(String id);

  Future<bool> editUserData(UserModel user);
}

