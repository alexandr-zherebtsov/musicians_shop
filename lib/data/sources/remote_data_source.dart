import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';

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

  Future<bool> editUserData(UserModel user);

  Future<String?> uploadFile({
    required XFile file,
    required FileTypeEnums type,
  });

  Future<bool> deleteFile(String fileUrl);
}
