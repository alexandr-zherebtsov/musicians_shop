import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musicians_shop/data/remote/adverts_repository.dart';
import 'package:musicians_shop/data/remote/handle_errors_repository.dart';
import 'package:musicians_shop/domain/repositories/adverts_repository_impl.dart';
import 'package:musicians_shop/data/remote/file_repository.dart';
import 'package:musicians_shop/domain/repositories/file_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';

class AdvertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileRepository>(
      () => FileRepositoryImpl(
        FirebaseStorage.instance,
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
    Get.lazyPut<AdvertController>(
      () => AdvertController(
        Get.find<FileRepository>(),
        Get.find<AdvertsRepository>(),
      ),
    );
  }
}
