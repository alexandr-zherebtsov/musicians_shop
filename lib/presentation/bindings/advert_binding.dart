import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_data_provider.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/file/file_data_provider.dart';
import 'package:musicians_shop/data/remote/file/file_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors/handle_errors_repository.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';

class AdvertBinding extends Bindings {
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
    Get.put<AdvertController>(
      AdvertController(
        Get.find<IFileRepository>(),
        Get.find<IAdvertsRepository>(),
      ),
    );
    Get.put<AdvertsController>(
      AdvertsController(
        Get.find<IAdvertsRepository>(),
      ),
    );
  }
}
