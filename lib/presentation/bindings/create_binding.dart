import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_data_provider.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/brands/brands_data_provider.dart';
import 'package:musicians_shop/data/remote/brands/brands_repository.dart';
import 'package:musicians_shop/data/remote/file/file_data_provider.dart';
import 'package:musicians_shop/data/remote/file/file_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_data_provider.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/remote/user/user_data_provider.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IFileRepository>(
      () => FileRepository(
        dataProvider: FileDataProvider(
          storage: FirebaseStorage.instance,
          errorHandler: Get.find<IHandleErrorsRepository>(),
        ),
      ),
      fenix: true,
    );
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
    Get.lazyPut<IAdvertsRepository>(
      () => AdvertsRepository(
        dataProvider: AdvertsDataProvider(
          logger: Get.find<Logger>(),
          firestore: FirebaseFirestore.instance,
          analytics: FirebaseAnalytics.instance,
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
    Get.put<CreateController>(
      CreateController(
        FirebaseAuth.instance.currentUser!.uid,
        Get.find<IFileRepository>(),
        Get.find<IUserRepository>(),
        Get.find<IBrandsRepository>(),
        Get.find<IAdvertsRepository>(),
        Get.find<IInstrumentTypesRepository>(),
      ),
    );
  }
}
