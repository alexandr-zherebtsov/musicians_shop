import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/brands/brands_repository.dart';
import 'package:musicians_shop/data/repositories/brands/brands_repository_impl.dart';
import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository_impl.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<InstrumentTypesRepository>(
      () => InstrumentTypesRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<BrandsRepository>(
      () => BrandsRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        FirebaseAuth.instance.currentUser!.uid,
        Get.find<UserRepository>(),
        Get.find<InstrumentTypesRepository>(),
        Get.find<BrandsRepository>(),
      ),
    );
  }
}
