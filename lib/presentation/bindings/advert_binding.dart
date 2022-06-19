import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository_impl.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository_impl.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';

class AdvertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileRepository>(
      () => FileRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AdvertsRepository>(
      () => AdvertsRepositoryImpl(
        Get.find<RemoteDataSource>(),
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
