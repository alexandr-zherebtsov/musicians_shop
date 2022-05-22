import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository_impl.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';

class AdvertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertController>(() => AdvertController());
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<AdvertsRepository>(() => AdvertsRepositoryImpl(Get.find()), fenix: true);
  }
}
