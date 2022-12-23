import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/brands_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/brands_repository_impl.dart';
import 'package:musicians_shop/data/remote/instrument_types_repository.dart';
import 'package:musicians_shop/domain/repositories/instrument_types_repository_impl.dart';
import 'package:musicians_shop/data/remote/user_repository.dart';
import 'package:musicians_shop/domain/repositories/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<Logger>(),
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<InstrumentTypesRepository>(
      () => InstrumentTypesRepositoryImpl(
        Get.find<Logger>(),
        FirebaseFirestore.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<BrandsRepository>(
      () => BrandsRepositoryImpl(
        Get.find<Logger>(),
        FirebaseFirestore.instance,
        Get.find<HandleErrorsRepository>(),
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
