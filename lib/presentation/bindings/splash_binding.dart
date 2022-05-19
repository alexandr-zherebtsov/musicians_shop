import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));
    Get.put(SplashController());
  }
}
