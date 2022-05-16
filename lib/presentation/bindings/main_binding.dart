import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
