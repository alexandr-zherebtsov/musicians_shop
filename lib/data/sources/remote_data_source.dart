import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
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

  Future<User?> getFirebaseUser();

  Future<UserModel?> getUser(String uid);

  Future<UserModel?> createUser(UserModel user);

  Future<bool> deleteUserData(String id);

  Future<bool> editUserData(UserModel user);

  Future<String?> uploadFile({
    required PlatformFile file,
    required FileTypeEnums type,
  });

  Future<bool> deleteFile(String fileUrl);

  Future<List<AdvertModel>> getAdverts();

  Future<bool> createAdvert(AdvertModel advert);

  Future<bool> editAdvert(AdvertModel advert);

  Future<bool> deleteAdvert(String id);

  Future<List<AdvertModel>> getMyAdverts(String uid);

  Future<List<AdvertModel>> getLikedAdverts(String uid);

  Future<List<InstrumentTypeModel>> getInstrumentTypes();

  Future<bool> createInstrumentType(InstrumentTypeModel type);

  Future<List<BrandModel>> getBrands();

  Future<bool> createBrand(BrandModel brand);

  Future<bool> initializePN();
}
