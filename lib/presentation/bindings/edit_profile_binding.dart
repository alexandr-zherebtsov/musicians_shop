import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/brands/brands_data_provider.dart';
import 'package:musicians_shop/data/remote/brands/brands_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_data_provider.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/remote/user/user_data_provider.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUserRepository>(
      () => UserRepository(
        dataProvider: UserDataProvider(
          logger: Get.find<Logger>(),
          auth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IInstrumentTypesRepository>(
      () => InstrumentTypesRepository(
        dataProvider: InstrumentTypesDataProvider(
          logger: Get.find<Logger>(),
          firestore: FirebaseFirestore.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<IBrandsRepository>(
      () => BrandsRepository(
        dataProvider: BrandsDataProvider(
          logger: Get.find<Logger>(),
          firestore: FirebaseFirestore.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        FirebaseAuth.instance.currentUser?.uid,
        Get.find<IUserRepository>(),
        Get.find<IInstrumentTypesRepository>(),
        Get.find<IBrandsRepository>(),
      ),
    );
  }
}
