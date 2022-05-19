import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/domain/models/user_model.dart';

abstract class RemoteDataSource {
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  });

  Future<User?> registerEmailPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<bool> deleteUser();

  Future<UserModel?> getUser(String uid);

  Future<UserModel?> createUser(UserModel user);

  Future<bool> deleteUserData(String id);
}
