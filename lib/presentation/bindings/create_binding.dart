import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/adverts_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/adverts_repository_impl.dart';
import 'package:musicians_shop/data/remote/brands_repository.dart';
import 'package:musicians_shop/domain/repositories/brands_repository_impl.dart';
import 'package:musicians_shop/data/remote/file_repository.dart';
import 'package:musicians_shop/domain/repositories/file_repository_impl.dart';
import 'package:musicians_shop/data/remote/instrument_types_repository.dart';
import 'package:musicians_shop/domain/repositories/instrument_types_repository_impl.dart';
import 'package:musicians_shop/data/remote/user_repository.dart';
import 'package:musicians_shop/domain/repositories/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileRepository>(
      () => FileRepositoryImpl(
        FirebaseStorage.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<Logger>(),
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
        Get.find<HandleErrorsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AdvertsRepository>(
      () => AdvertsRepositoryImpl(
        Get.find<Logger>(),
        FirebaseFirestore.instance,
        FirebaseAnalytics.instance,
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
    Get.lazyPut<CreateController>(
      () => CreateController(
        FirebaseAuth.instance.currentUser!.uid,
        Get.find<FileRepository>(),
        Get.find<UserRepository>(),
        Get.find<BrandsRepository>(),
        Get.find<AdvertsRepository>(),
        Get.find<InstrumentTypesRepository>(),
      ),
    );
  }
}
