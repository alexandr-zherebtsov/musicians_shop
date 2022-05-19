import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository_impl.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<MyProfileController>(() => MyProfileController());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()), fenix: true);
  }
}
