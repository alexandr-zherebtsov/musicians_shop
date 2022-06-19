import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository_impl.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository_impl.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository_impl.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
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
  }
}
