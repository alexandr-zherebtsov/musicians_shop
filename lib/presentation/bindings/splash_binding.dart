import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<SplashController>(() => SplashController());
  }
}
