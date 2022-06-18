import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository_impl.dart';
import 'package:musicians_shop/data/repositories/brands/brands_repository.dart';
import 'package:musicians_shop/data/repositories/brands/brands_repository_impl.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository_impl.dart';
import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository_impl.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileRepository>(
      () => FileRepositoryImpl(Get.find<RemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(Get.find<RemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<AdvertsRepository>(
      () => AdvertsRepositoryImpl(Get.find<RemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<InstrumentTypesRepository>(
      () => InstrumentTypesRepositoryImpl(Get.find<RemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<BrandsRepository>(
      () => BrandsRepositoryImpl(Get.find<RemoteDataSource>()),
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
