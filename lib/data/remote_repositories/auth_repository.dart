import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/shared/core/base/base_repository.dart';

abstract class AuthRepository extends BaseRepository {
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
}