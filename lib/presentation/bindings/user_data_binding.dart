import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';

class UserDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find<RemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserDataController>(
      () => UserDataController(
        Get.find<UserRepository>(),
      ),
    );
  }
}
